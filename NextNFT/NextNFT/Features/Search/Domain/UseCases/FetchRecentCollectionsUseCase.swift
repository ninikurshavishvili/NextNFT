//
//  FetchRecentCollectionsUseCase.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 08.01.26.
//

import Foundation

final class FetchRecentCollectionsUseCase {
    private let repository: NFTRepositoryProtocol
    
    init(repository: NFTRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async throws -> [NFTCollection] {
        // Recent Ethereum collections from the shared NFT repository
        return try await repository.getCollections()
    }
}
