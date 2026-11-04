//
//  NFTPostDownloadActionHandling.swift
//  NextNFT
//
//  Created by Nini Kurshavishvili on 26.03.26.
//

import UIKit

protocol NFTPostDownloadActionHandling {
    func handle(action: DownloadAction, localFileURL: URL)
}

final class NFTPostDownloadActionHandler: NFTPostDownloadActionHandling {
    private let authorizer: PhotoLibraryAuthorizing

    init(authorizer: PhotoLibraryAuthorizing = PhotoLibraryAuthorizer()) {
        self.authorizer = authorizer
    }

    func handle(action: DownloadAction, localFileURL: URL) {
        guard let image = UIImage(contentsOfFile: localFileURL.path) else { return }

        switch action {
        case .copy:
            UIPasteboard.general.image = image

        case .saveToPhotos:
            authorizer.requestAddOnlyAuthorization { granted in
                guard granted else { return }
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            }
        }
    }
}
