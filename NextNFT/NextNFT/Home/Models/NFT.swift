//
//  NFTModel.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 14.07.25.
//

import Foundation
import FirebaseDatabase

struct NFT: Identifiable, Codable {
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
    var volumeChange: String?
}


extension NFT {
    init?(snapshot: DataSnapshot) {
        guard let value = snapshot.value as? [String: Any] else {
            return nil
        }
        
        self.id = value["ID"] as? Int ?? 0
        self.collectionName = value["CollectionName"] as? String ?? ""
        self.creator = value["Creator"] as? String ?? ""
        self.description = value["Description"] as? String ?? ""
        self.floorChange = value["FloorChange"] as? Double
        self.floorPrice = value["FloorPrice"] as? String ?? ""
        self.imageURL = value["ImageURL"] as? String ?? ""
        self.items = value["Items"] as? Int ?? 0
        self.likes = value["Likes"] as? Int ?? 0
        self.nftName = value["NFTName"] as? String ?? ""
        self.owner = value["Owner"] as? String ?? ""
        self.owners = value["Owners"] as? Int ?? 0
        self.price = value["Price"] as? String ?? ""
        self.volume = value["Volume"] as? Double
        self.volumeChange = value["VolumeChange"] as? String
    }
}
