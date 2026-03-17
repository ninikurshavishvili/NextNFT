//
//  NFTImageActionsModifier.swift
//  NextNFT
//
//  Created by Nini Kurshavishvili on 17.03.26.
//

import SwiftUI

struct NFTImageActionsModifier: ViewModifier {
    let nft: NFT
    @State private var downloadTaskID: String?
    @State private var showProgress = false
    @State private var progress: Double = 0
    @State private var showSuccess = false
    @State private var showError = false
    
    private let downloadManager = NFTImageDownloadManager.shared
    
    func body(content: Content) -> some View {
        content
            .contextMenu {
                Button {
                    startDownload(action: .copy)
                } label: {
                    Label("Copy Image", systemImage: "doc.on.doc")
                }
                
                Button {
                    startDownload(action: .saveToPhotos)
                } label: {
                    Label("Save to Photos", systemImage: "square.and.arrow.down")
                }
            }
            .overlay {
                if showProgress {
                    ProgressView(value: progress, total: 1.0)
                        .progressViewStyle(.circular)
                        .tint(.blue)
                        .frame(width: 40, height: 40)
                        .background(Color.black.opacity(0.7))
                        .cornerRadius(8)
                }
            }
            .alert("Success", isPresented: $showSuccess) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Image saved successfully")
            }
            .alert("Error", isPresented: $showError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Failed to download image")
            }
            .task(id: downloadTaskID) {
                guard let taskID = downloadTaskID else { return }
                
                showProgress = true
                
                for await state in await downloadManager.observeTask(taskID) {
                    switch state {
                    case .downloading(let downloadProgress):
                        progress = downloadProgress
                        
                    case .completed:
                        showProgress = false
                        showSuccess = true
                        downloadTaskID = nil
                        
                    case .failed:
                        showProgress = false
                        showError = true
                        downloadTaskID = nil
                        
                    default:
                        break
                    }
                }
            }
    }
    
    private func startDownload(action: DownloadAction) {
        downloadTaskID = downloadManager.startDownload(nft: nft, action: action)
    }
}

extension View {
    func nftImageActions(for nft: NFT) -> some View {
        modifier(NFTImageActionsModifier(nft: nft))
    }
}
