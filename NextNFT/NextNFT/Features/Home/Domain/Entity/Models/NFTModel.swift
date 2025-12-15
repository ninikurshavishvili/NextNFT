//
//  NFTModel.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 26.10.25.
//

import Foundation

struct NFTModel: Codable, Identifiable {
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

    enum CodingKeys: String, CodingKey {
        case identifier
        case collection
        case contract
        case tokenStandard = "token_standard"
        case name
        case description
        case imageURL = "image_url"
        case displayImageURL = "display_image_url"
        case displayAnimationURL = "display_animation_url"
        case metadataURL = "metadata_url"
        case openseaURL = "opensea_url"
        case updatedAt = "updated_at"
        case isDisabled = "is_disabled"
        case isNsfw = "is_nsfw"
    }
}

struct NFTResponse: Codable {
    let nfts: [NFTModel]
    let next: String?
}

