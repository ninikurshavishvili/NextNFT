//
//  NFTModel.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 14.07.25.
//

import Foundation
import Foundation

struct NFTCollection: Identifiable, Codable {
    var id: Int
    var collectionName: String
    var creator: String
    var description: String
    var floorChange: Double?
    var floorPrice: String
    var imageURL: String
    var items: Int
    var likes: Int
    var nftName: String
    var owner: String
    var owners: Int
    var price: String
    var volume: Double?
    var volumeChange: String? // might be error/null, anu keeping it String
}

