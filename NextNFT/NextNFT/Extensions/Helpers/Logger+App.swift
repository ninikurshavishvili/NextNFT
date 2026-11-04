//
//  Logger+App.swift
//  NextNFT
//

import OSLog

extension Logger {
    private static let subsystem = Bundle.main.bundleIdentifier ?? "nini.NextNFT"

    static let app = Logger(subsystem: subsystem, category: "App")
    static let network = Logger(subsystem: subsystem, category: "Network")
    static let home = Logger(subsystem: subsystem, category: "Home")
    static let downloads = Logger(subsystem: subsystem, category: "Downloads")
}
