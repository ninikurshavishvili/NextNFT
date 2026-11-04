//
//  NFTImageDownloadModels.swift
//  NextNFT
//
//  Created by Nini Kurshavishvili on 26.03.26.
//

import Foundation


enum DownloadAction {
    case copy
    case saveToPhotos
}

enum DownloadState {
    case pending
    case downloading(progress: Double)
    case completed(localURL: URL)
    case failed(Error)
}

struct DownloadTask {
    let id: String
    let nftID: String
    let url: URL
    let action: DownloadAction
    var state: DownloadState
    var task: URLSessionDownloadTask?
}
