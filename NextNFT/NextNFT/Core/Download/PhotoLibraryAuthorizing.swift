//
//  PhotoLibraryAuthorizing.swift
//  NextNFT
//
//  Created by Nini Kurshavishvili on 26.03.26.
//

import Photos

protocol PhotoLibraryAuthorizing {
    func requestAddOnlyAuthorization(completion: @escaping (Bool) -> Void)
}

final class PhotoLibraryAuthorizer: PhotoLibraryAuthorizing {
    func requestAddOnlyAuthorization(completion: @escaping (Bool) -> Void) {
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
