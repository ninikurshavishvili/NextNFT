//
//  PhotoLibraryAuthorizing.swift
//  NextNFT
//
//  Created by Nini Kurshavishvili on 26.03.26.
//

import Photos

protocol PhotoLibraryAuthorizing: Sendable {
    func requestAddOnlyAuthorization() async -> Bool
}

final class PhotoLibraryAuthorizer: PhotoLibraryAuthorizing {
    func requestAddOnlyAuthorization() async -> Bool {
        let status = await PHPhotoLibrary.requestAuthorization(for: .addOnly)
        switch status {
        case .authorized, .limited:
            return true
        default:
            return false
        }
    }
}
