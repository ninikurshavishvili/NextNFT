//
//  CollectionModel.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 25.10.25.
//

import Foundation

struct CollectionModel: Codable, Identifiable {
    let id = UUID()
    let collection: String
    let name: String
    let description: String?
    let imageURL: String?
    let bannerImageURL: String?
    let owner: String?
    let category: String?
    let openseaURL: String?

    enum CodingKeys: String, CodingKey {
        case collection
        case name
        case description
        case imageURL = "image_url"
        case bannerImageURL = "banner_image_url"
        case owner
        case category
        case openseaURL = "opensea_url"
    }
}

// For the API response wrapper
struct CollectionsResponse: Codable {
    let collections: [CollectionModel]
}
