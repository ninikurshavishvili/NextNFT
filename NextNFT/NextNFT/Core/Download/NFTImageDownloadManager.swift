//
//  NFTImageDownloadManager.swift
//  NextNFT
//
//  Created by Nini Kurshavishvili on 17.03.26.
//

import SwiftUI
import UIKit
import Photos


// MARK: - Download Manager Protocol
//protocol NFTImageDownloadManagerProtocol {
//    func startDownload(nft: NFT, action: DownloadAction) -> String
//    func cancelDownload(taskID: String)
//    func getProgress(for taskID: String) -> Double?
//    func observeTask(_ taskID: String) async -> AsyncStream<DownloadState>
//}

// MARK: - Download Manager Implementation
final class NFTImageDownloadManager: NSObject, NFTImageDownloadManagerProtocol {
    static let shared = NFTImageDownloadManager()
    
    // MARK: - Private Properties
    private var activeTasks: [String: DownloadTask] = [:]
    private var continuations: [String: AsyncStream<DownloadState>.Continuation] = [:]
    private lazy var urlSession: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForResource = 300
        return URLSession(configuration: config, delegate: self, delegateQueue: .main)
    }()
    
    // MARK: - Public Methods
    func startDownload(nft: NFT, action: DownloadAction) -> String {
        let taskID = UUID().uuidString
        let imageURLString = nft.displayImageURL ?? nft.imageURL ?? ""
        
        guard let url = URL(string: imageURLString) else {
            print("Invalid URL for NFT: \(nft.name ?? nft.identifier)")
            return taskID
        }
        
        let downloadTask = urlSession.downloadTask(with: url)
        let task = DownloadTask(
            id: taskID,
            nftID: nft.identifier,
            url: url,
            action: action,
            state: .pending,
            task: downloadTask
        )
        
        activeTasks[taskID] = task
        downloadTask.resume()
        
        return taskID
    }
    
    func cancelDownload(taskID: String) {
        activeTasks[taskID]?.task?.cancel()
        activeTasks.removeValue(forKey: taskID)
        continuations[taskID]?.finish()
        continuations.removeValue(forKey: taskID)
    }
    
    func getProgress(for taskID: String) -> Double? {
        guard case .downloading(let progress) = activeTasks[taskID]?.state else {
            return nil
        }
        return progress
    }
    
    func observeTask(_ taskID: String) async -> AsyncStream<DownloadState> {
        AsyncStream { continuation in
            self.continuations[taskID] = continuation
            
            // Send current state if exists
            if let task = activeTasks[taskID] {
                continuation.yield(task.state)
            }
            
            continuation.onTermination = { @Sendable _ in
                self.continuations.removeValue(forKey: taskID)
            }
        }
    }
    
    // MARK: - Private Methods
    private func handleDownloadCompletion(taskID: String, location: URL) {
        guard var task = activeTasks[taskID] else { return }
        
        // Move file to permanent location
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let destinationURL = documentsPath.appendingPathComponent("\(task.nftID)_\(Date().timeIntervalSince1970).jpg")
        
        do {
            try FileManager.default.moveItem(at: location, to: destinationURL)
            task.state = .completed(localURL: destinationURL)
            activeTasks[taskID] = task
            
            // Handle the action
            handleAction(task: task, imageURL: destinationURL)
            
            continuations[taskID]?.yield(.completed(localURL: destinationURL))
            continuations[taskID]?.finish()
            
        } catch {
            task.state = .failed(error)
            activeTasks[taskID] = task
            continuations[taskID]?.yield(.failed(error))
            continuations[taskID]?.finish()
        }
    }
    
    private func handleAction(task: DownloadTask, imageURL: URL) {
        guard let image = UIImage(contentsOfFile: imageURL.path) else { return }
        
        switch task.action {
        case .copy:
            UIPasteboard.general.image = image
            
        case .saveToPhotos:
            requestPhotoLibraryAccess { granted in
                if granted {
                    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                }
            }
        }
    }
    
    private func requestPhotoLibraryAccess(completion: @escaping (Bool) -> Void) {
        PHPhotoLibrary.requestAuthorization(for: .addOnly) { status in
            DispatchQueue.main.async {
                switch status {
                case .authorized, .limited:
                    completion(true)
                default:
                    completion(false)
                }
            }
        }
    }
}

// MARK: - URLSessionDownloadDelegate
extension NFTImageDownloadManager: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        guard let taskID = activeTasks.first(where: { $0.value.task == downloadTask })?.key,
              var task = activeTasks[taskID] else { return }
        
        let progress = Double(totalBytesWritten) / Double(totalBytesExpectedToWrite)
        task.state = .downloading(progress: progress)
        activeTasks[taskID] = task
        
        continuations[taskID]?.yield(.downloading(progress: progress))
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        guard let taskID = activeTasks.first(where: { $0.value.task == downloadTask })?.key else { return }
        handleDownloadCompletion(taskID: taskID, location: location)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error,
           let taskID = activeTasks.first(where: { $0.value.task == task })?.key,
           var failedTask = activeTasks[taskID] {
            
            failedTask.state = .failed(error)
            activeTasks[taskID] = failedTask
            continuations[taskID]?.yield(.failed(error))
            continuations[taskID]?.finish()
        }
    }
}
