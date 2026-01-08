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

//// Features/Search/Domain/UseCases/FetchRecentCollectionsUseCase.swift
//final class FetchRecentCollectionsUseCase {
//    private let repository: HomeRepositoryProtocol  // Uses HomeRepository to get collections
//
//    init(repository: HomeRepositoryProtocol = HomeRepository()) {
//        self.repository = repository
//    }
//
//    func execute() async throws -> [NFTCollection] {
//        // This gets recent collections from the Home repository
//        return try await repository.getCollections()
//    }
//}

// Features/Search/Domain/UseCases/FetchRecentCollectionsUseCase.swift
import Foundation

final class FetchRecentCollectionsUseCase {
    private let repository: HomeRepositoryProtocol
    
    init(repository: HomeRepositoryProtocol = HomeRepository()) {
        self.repository = repository
    }
    
    func execute() async throws -> [NFTCollection] {
        // This gets recent collections from the Home repository
        // The repository will use its default parameters (chain: "ethereum", limit: 10)
        return try await repository.getCollections()
    }
    
    // Optional: Add a version with parameters if needed
    func execute(chain: String = "ethereum", limit: Int = 10) async throws -> [NFTCollection] {
        // Note: You might need to update your HomeRepositoryProtocol
        // to support parameters, or create a different method
        return try await repository.getCollections()
    }
}
