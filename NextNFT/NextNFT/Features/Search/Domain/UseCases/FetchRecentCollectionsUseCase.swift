//
//  FetchRecentCollectionsUseCase.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 08.01.26.
//

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
