//
//  CollectionDTO.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 15.12.25.
//


// Network/Models/DTO/CollectionDTO.swift
struct CollectionDTO: Codable {
    let identifier: String?
    let name: String?
    let imageUrl: String?
    let description: String?
    let slug: String?
    
    enum CodingKeys: String, CodingKey {
        case identifier = "identifier"
        case name = "name"
        case imageUrl = "image_url"
        case description = "description"
        case slug = "slug"
    }
}

struct CollectionsResponseDTO: Codable {
    let collections: [CollectionDTO]
}

// Network/Models/DTO/NFTDTO.swift
struct NFTDTO: Codable {
    let identifier: String?
    let name: String?
    let imageUrl: String?
    let collection: String?
    let contract: String?
    let tokenId: String?
    
    enum CodingKeys: String, CodingKey {
        case identifier = "identifier"
        case name = "name"
        case imageUrl = "image_url"
        case collection = "collection"
        case contract = "contract"
        case tokenId = "token_id"
    }
}

struct NFTResponseDTO: Codable {
    let nfts: [NFTDTO]
}