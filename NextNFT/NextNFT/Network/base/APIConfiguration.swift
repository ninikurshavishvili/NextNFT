//
//  APIConfiguration.swift
//  NextNFT
//

import Foundation
import OSLog

enum APIConfiguration {
    /// Injected at build time: Config.xcconfig -> Info.plist -> Bundle.
    static let openSeaAPIKey: String = {
        let key = Bundle.main.object(forInfoDictionaryKey: "OPENSEA_API_KEY") as? String ?? ""
        if key.isEmpty {
            Logger.network.error("OPENSEA_API_KEY is missing. Copy Config.example.xcconfig to Config.xcconfig and add your key.")
        }
        return key
    }()
}
