//
//  NFTRemoteDataSourceProtocol.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 15.12.25.
//

protocol NFTRemoteDataSourceProtocol {
    func fetchCollections(chain: String, limit: Int) async throws -> [CollectionDTO]
    func fetchNFTs(collectionSlug: String, limit: Int) async throws -> [NFTDTO]
}

extension NFTRemoteDataSourceProtocol {
    func fetchCollections(chain: String = "ethereum", limit: Int = 10) async throws -> [CollectionDTO] {
        try await fetchCollections(chain: chain, limit: limit)
    }
    
    func fetchNFTs(collectionSlug: String, limit: Int = 10) async throws -> [NFTDTO] {
        try await fetchNFTs(collectionSlug: collectionSlug, limit: limit)
    }
}
