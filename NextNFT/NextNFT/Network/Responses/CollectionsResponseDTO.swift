//
//  CollectionsResponseDTO.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 15.12.25.
//


struct CollectionsResponseDTO: Codable {
    let collections: [CollectionDTO]
    
    func toDomain() -> [NFTCollection] {
        return collections.map { $0.toDomain() }
    }
}
