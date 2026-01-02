//
//  NFTDTO.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 15.12.25.
//

// Network/Models/DTO/NFTDTO.swift
struct NFTDTO: Codable {
    let identifier: String
    let collection: String
    let contract: String?
    let tokenStandard: String?
    let name: String?
    let description: String?
    let imageUrl: String?
    let displayImageUrl: String?
    let displayAnimationUrl: String?
    let metadataUrl: String?
    let openseaUrl: String?
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
        case imageUrl = "image_url"
        case displayImageUrl = "display_image_url"
        case displayAnimationUrl = "display_animation_url"
        case metadataUrl = "metadata_url"
        case openseaUrl = "opensea_url"
        case updatedAt = "updated_at"
        case isDisabled = "is_disabled"
        case isNsfw = "is_nsfw"
    }
    
    func toDomain() -> NFT {
        return NFT(
            identifier: identifier,
            collection: collection,
            contract: contract,
            tokenStandard: tokenStandard,
            name: name,
            description: description,
            imageURL: imageUrl,
            displayImageURL: displayImageUrl,
            displayAnimationURL: displayAnimationUrl,
            metadataURL: metadataUrl,
            openseaURL: openseaUrl,
            updatedAt: updatedAt,
            isDisabled: isDisabled,
            isNsfw: isNsfw
        )
    }
}
