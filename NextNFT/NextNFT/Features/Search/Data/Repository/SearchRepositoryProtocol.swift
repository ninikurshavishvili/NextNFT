//
//  SearchRepositoryProtocol.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 02.01.26.
//

protocol SearchRepositoryProtocol {
    func searchCollections(query: String) async throws -> [NFTCollection]
    func searchNFTs(query: String) async throws -> [NFT]
}


// SearchRepositoryProtocol.swift
//protocol SearchRepositoryProtocol {
//    func searchCollections(query: String) async throws -> [NFTCollection]
//    func searchNFTs(query: String) async throws -> [NFT]
//}

// SearchCollectionsUseCase.swift


// SearchViewModel.swift
// Uses SearchCollectionsUseCase for search results
