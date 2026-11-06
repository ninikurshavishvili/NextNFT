//
//  NFTImageDownloadManager.swift
//  NextNFT
//
//  Created by Nini Kurshavishvili on 17.03.26.
//

import Foundation
import SwiftUI
import UIKit
import Photos
import OSLog



/// Main actor: all state lives on the main thread, and URLSession delivers
/// delegate callbacks on the main queue (`delegateQueue: .main`).
@MainActor
final class NFTImageDownloadManager: NSObject, NFTImageDownloadManagerProtocol {
    // MARK: Dependencies
    private let fileStore: DownloadedFileStoring
    private let actionHandler: NFTPostDownloadActionHandling

    // MARK: State
    private var activeTasks: [String: DownloadTask] = [:]
    private var continuations: [String: AsyncStream<DownloadState>.Continuation] = [:]

    // MARK: URLSession
    private lazy var urlSession: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForResource = 300
        return URLSession(configuration: config, delegate: self, delegateQueue: .main)
    }()

    // MARK: Init
    init(
        fileStore: DownloadedFileStoring = DownloadedFileStore(),
        actionHandler: NFTPostDownloadActionHandling = NFTPostDownloadActionHandler()
    ) {
        self.fileStore = fileStore
        self.actionHandler = actionHandler
        super.init()
    }

    // MARK: Public API

    func startDownload(nft: NFT, action: DownloadAction) -> String {
        let taskID = UUID().uuidString

        guard let url = makeNFTImageURL(from: nft) else {
            Logger.downloads.error("Invalid image URL for NFT: \(nft.name ?? nft.identifier)")
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
        finishObservation(for: taskID)
    }

    func getProgress(for taskID: String) -> Double? {
        guard case .downloading(let progress) = activeTasks[taskID]?.state else { return nil }
        return progress
    }

    func observeTask(_ taskID: String) async -> AsyncStream<DownloadState> {
        let (stream, continuation) = AsyncStream.makeStream(of: DownloadState.self)
        continuations[taskID] = continuation

        if let task = activeTasks[taskID] {
            continuation.yield(task.state)
        }

        // Called from whichever thread ends the stream; hop back to the main actor
        continuation.onTermination = { [weak self] _ in
            guard let self else { return }
            Task { @MainActor in
                self.continuations.removeValue(forKey: taskID)
            }
        }
        return stream
    }

    // MARK: Private - Helpers

    private func makeNFTImageURL(from nft: NFT) -> URL? {
        let imageURLString = nft.displayImageURL ?? nft.imageURL ?? ""
        return URL(string: imageURLString)
    }

    private func taskID(for urlSessionTask: URLSessionTask) -> String? {
        activeTasks.first(where: { $0.value.task == urlSessionTask })?.key
    }

    private func yield(_ state: DownloadState, for taskID: String) {
        continuations[taskID]?.yield(state)
    }

    private func finishObservation(for taskID: String) {
        continuations[taskID]?.finish()
        continuations.removeValue(forKey: taskID)
    }

    private func updateProgress(taskID: String, progress: Double) {
        guard var task = activeTasks[taskID] else { return }
        task.state = .downloading(progress: progress)
        activeTasks[taskID] = task
        yield(.downloading(progress: progress), for: taskID)
    }

    private func completeDownload(taskID: String, tempLocation: URL) {
        guard var task = activeTasks[taskID] else { return }

        do {
            let destinationURL = try fileStore.moveDownloadedTempFile(from: tempLocation, nftID: task.nftID)

            task.state = .completed(localURL: destinationURL)
            activeTasks[taskID] = task

            actionHandler.handle(action: task.action, localFileURL: destinationURL)

            yield(.completed(localURL: destinationURL), for: taskID)
            finishObservation(for: taskID)
        } catch {
            task.state = .failed(error)
            activeTasks[taskID] = task

            yield(.failed(error), for: taskID)
            finishObservation(for: taskID)
        }
    }

    private func failDownload(taskID: String, error: Error) {
        guard var task = activeTasks[taskID] else { return }
        task.state = .failed(error)
        activeTasks[taskID] = task

        yield(.failed(error), for: taskID)
        finishObservation(for: taskID)
    }
}

// MARK: - URLSessionDownloadDelegate
// URLSession calls these on `delegateQueue` (.main), so `assumeIsolated` is
// safe, and it stays synchronous: the temp file at `location` is deleted as
// soon as `didFinishDownloadingTo` returns.
extension NFTImageDownloadManager: URLSessionDownloadDelegate {
    nonisolated func urlSession(
        _ session: URLSession,
        downloadTask: URLSessionDownloadTask,
        didWriteData bytesWritten: Int64,
        totalBytesWritten: Int64,
        totalBytesExpectedToWrite: Int64
    ) {
        MainActor.assumeIsolated {
            guard totalBytesExpectedToWrite > 0,
                  let taskID = taskID(for: downloadTask)
            else { return }

            let progress = Double(totalBytesWritten) / Double(totalBytesExpectedToWrite)
            updateProgress(taskID: taskID, progress: progress)
        }
    }

    nonisolated func urlSession(
        _ session: URLSession,
        downloadTask: URLSessionDownloadTask,
        didFinishDownloadingTo location: URL
    ) {
        MainActor.assumeIsolated {
            guard let taskID = taskID(for: downloadTask) else { return }
            completeDownload(taskID: taskID, tempLocation: location)
        }
    }

    nonisolated func urlSession(
        _ session: URLSession,
        task: URLSessionTask,
        didCompleteWithError error: Error?
    ) {
        MainActor.assumeIsolated {
            guard let error,
                  let taskID = taskID(for: task)
            else { return }

            failDownload(taskID: taskID, error: error)
        }
    }
}
