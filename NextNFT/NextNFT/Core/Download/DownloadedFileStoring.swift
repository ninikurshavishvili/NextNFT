//
//  DownloadedFileStoring.swift
//  NextNFT
//
//  Created by Nini Kurshavishvili on 26.03.26.
//

import Foundation

protocol DownloadedFileStoring {
    func moveDownloadedTempFile(from location: URL, nftID: String) throws -> URL
}

final class DownloadedFileStore: DownloadedFileStoring {
    func moveDownloadedTempFile(from location: URL, nftID: String) throws -> URL {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let destination = documents.appendingPathComponent("\(nftID)_\(Date().timeIntervalSince1970).jpg")

        // Defensive: avoid rare collisions
        if FileManager.default.fileExists(atPath: destination.path) {
            try FileManager.default.removeItem(at: destination)
        }

        try FileManager.default.moveItem(at: location, to: destination)
        return destination
    }
}
