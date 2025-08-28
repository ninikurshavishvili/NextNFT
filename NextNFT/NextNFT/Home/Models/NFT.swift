//
//  NFTModel.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 14.07.25.
//

import Foundation

struct NFT: Identifiable, Codable {
    let id: Int
    let collectionName: String
    let creator: String
    let description: String
    let floorChange: Double?
    let floorPrice: String
    let imageURL: String
    let items: Int
    let likes: Int
    let nftName: String
    let owner: String
    let owners: Int
    let price: String
    let volume: Double?
    let volumeChange: String? 
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case collectionName = "CollectionName"
        case creator = "Creator"
        case description = "Description"
        case floorChange = "FloorChange"
        case floorPrice = "FloorPrice"
        case imageURL = "ImageURL"
        case items = "Items"
        case likes = "Likes"
        case nftName = "NFTName"
        case owner = "Owner"
        case owners = "Owners"
        case price = "Price"
        case volume = "Volume"
        case volumeChange = "VolumeChange"
    }
}

