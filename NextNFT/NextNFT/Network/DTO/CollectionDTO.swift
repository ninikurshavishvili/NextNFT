//
//  CollectionDTO.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 15.12.25.
//


// Network/Models/DTO/CollectionDTO.swift
struct CollectionDTO: Codable {
    let collection: String
    let name: String
    let description: String?
    let imageUrl: String?
    let bannerImageUrl: String?
    let owner: String?
    let category: String?
    let openseaUrl: String?
    let totalSupply: Int?
    let createdDate: String?

    enum CodingKeys: String, CodingKey {
        case collection
        case name
        case description
        case imageUrl = "image_url"
        case bannerImageUrl = "banner_image_url"
        case owner
        case category
        case openseaUrl = "opensea_url"
        case totalSupply = "total_supply"
        case createdDate = "created_date"
    }
    
    // Convert to your existing CollectionModel
    func toDomain() -> NFTCollection {
        return NFTCollection(
            collection: collection,
            name: name,
            description: description,
            imageURL: imageUrl,
            bannerImageURL: bannerImageUrl,
            owner: owner,
            category: category,
            openseaURL: openseaUrl,
            totalSupply: totalSupply,
            createdDate: createdDate
        )
    }
}



