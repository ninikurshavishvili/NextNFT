//
//  CollectionModel.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 25.10.25.
//

import Foundation

struct CollectionModel: Codable, Identifiable {
    // Use a stable id from the API if available; here we use `collection` (slug) as id.
    var id: String { collection }

    let collection: String             // e.g. slug or identifier
    let name: String
    let description: String?
    let imageURL: String?
    let bannerImageURL: String?
    let owner: String?
    let category: String?
    let openseaURL: String?
    let totalSupply: Int?
    let createdDate: String?

    // Add other fields as optional if you may need them later:
    // let isDisabled: Bool?
    // let isNsfw: Bool?
    // let contracts: [Contract]?

    enum CodingKeys: String, CodingKey {
        case collection
        case name
        case description
        case imageURL = "image_url"
        case bannerImageURL = "banner_image_url"
        case owner
        case category
        case openseaURL = "opensea_url"
        case totalSupply = "total_supply"
        case createdDate = "created_date"
    }
}

struct CollectionsResponse: Codable {
    // NOTE: confirm with the OpenSea response wrapper — if the top-level key is "collections" use this.
    // If the API returns an array directly, change to `typealias CollectionsResponse = [CollectionModel]`
    let collections: [CollectionModel]
}

