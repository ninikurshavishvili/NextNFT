//
//  NFTModel.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 14.07.25.
//

import Foundation
import FirebaseDatabase

struct NFT: Codable, Identifiable {
    let id: Int        // required for `Identifiable`, but we’ll generate it
    let nftName: String?
    let collectionName: String?
    let creator: String?
    let description: String?
    let price: String?
    let floorPrice: String?
    let imageURL: String?
    let owner: String?
    let items: Int?
    let owners: Int?
    let likes: Int?
    let volume: Double?
    let floorChange: Double?
    let volumeChange: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case nftName = "NFTName"
        case collectionName = "CollectionName"
        case creator = "Creator"
        case description = "Description"
        case price = "Price"
        case floorPrice = "FloorPrice"
        case imageURL = "ImageURL"
        case owner = "Owner"
        case items = "Items"
        case owners = "Owners"
        case likes = "Likes"
        case volume = "Volume"
        case floorChange = "FloorChange"
        case volumeChange = "VolumeChange"
    }
}
