//
//  SearchRecentCollectionsUseCase.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 07.01.26.
//



final class SearchRecentCollectionsUseCase {
    private let repository: SearchRepositoryProtocol  // ✅ Changed to SearchRepositoryProtocol

    init(repository: SearchRepositoryProtocol = SearchRepository()) {
        self.repository = repository
    }

    func execute() async throws -> [NFTCollection] {
        // This doesn't make sense without a query
        // Maybe you want trending/featured collections instead?
        fatalError("Search needs a query parameter")
    }
    
    // OR if you want trending collections:
    func executeTrending() async throws -> [NFTCollection] {
        // You could search with a default term like "trending" or ""
        // But OpenSea might not support this
        try await repository.searchCollections(query: "")
    }
}
