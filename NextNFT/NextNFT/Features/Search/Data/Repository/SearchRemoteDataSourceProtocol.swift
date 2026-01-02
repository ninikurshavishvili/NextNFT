//
//  SearchRemoteDataSourceProtocol.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 02.01.26.
//

protocol SearchRemoteDataSourceProtocol {
    func searchCollections(query: String, limit: Int) async throws -> [CollectionDTO]
    func searchNFTs(query: String, limit: Int) async throws -> [NFTDTO]
}

extension SearchRemoteDataSourceProtocol {
    func searchCollections(query: String, limit: Int = 10) async throws -> [CollectionDTO] {
        try await searchCollections(query: query, limit: limit)
    }

    func searchNFTs(query: String, limit: Int = 10) async throws -> [NFTDTO] {
        try await searchNFTs(query: query, limit: limit)
    }
}
