//
//  NFTCollection.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 25.10.25.
//

import Foundation

struct NFTCollection: Identifiable, Hashable, Sendable {
    var id: String { collection }

    let collection: String
    let name: String
    let description: String?
    let imageURL: String?
    let bannerImageURL: String?
    let owner: String?
    let category: String?
    let openseaURL: String?
    let totalSupply: Int?
    let createdDate: String?
}
