//
//  NFTImageDownloadManagerProtocol.swift
//  NextNFT
//
//  Created by Nini Kurshavishvili on 26.03.26.
//

import Foundation

protocol NFTImageDownloadManagerProtocol {
    func startDownload(nft: NFT, action: DownloadAction) -> String
    func cancelDownload(taskID: String)
    func getProgress(for taskID: String) -> Double?
    func observeTask(_ taskID: String) async -> AsyncStream<DownloadState>
}
