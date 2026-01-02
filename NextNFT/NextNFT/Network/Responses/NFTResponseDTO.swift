//
//  NFTResponseDTO 2.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 15.12.25.
//


struct NFTResponseDTO: Codable {
    let nfts: [NFTDTO]
    let next: String?
    
    func toDomain() -> [NFT] {
        return nfts.map { $0.toDomain() }
    }
}
