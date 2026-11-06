//
//  EnvironmentValues+Dependencies.swift
//  NextNFT
//

import SwiftUI

extension EnvironmentValues {
    /// Set at the app root from `AppContainer`. Nil in previews, which turns
    /// off the Copy Image / Save to Photos actions.
    @Entry var imageDownloadManager: NFTImageDownloadManagerProtocol? = nil
}
