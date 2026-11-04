//
//  NFT.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 26.10.25.
//

import Foundation

struct NFT: Identifiable, Hashable, Sendable {
    var id: String { identifier }

    let identifier: String
    let collection: String
    let contract: String?
    let tokenStandard: String?
    let name: String?
    let description: String?
    let imageURL: String?
    let displayImageURL: String?
    let displayAnimationURL: String?
    let metadataURL: String?
    let openseaURL: String?
    let updatedAt: String?
    let isDisabled: Bool?
    let isNsfw: Bool?
}
