//
//  GetCollectionsUseCase.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 15.12.25.
//


//TODO: - need to filter NFTs
//1

import Foundation

class GetCollectionsUseCase {
    private let repository: HomeRepositoryProtocol
    
    init(repository: HomeRepositoryProtocol = HomeRepository()) {
        self.repository = repository
    }
    
    func execute() async throws -> [NFTCollection] {
        try await repository.getCollections()
    }
}

// Features/Home/Domain/UseCases/GetNFTsUseCase.swift
class GetNFTsUseCase {
    private let repository: HomeRepositoryProtocol
    
    init(repository: HomeRepositoryProtocol = HomeRepository()) {
        self.repository = repository
    }
    
    func execute(for collectionSlug: String) async throws -> [NFT] {
        return try await repository.getNFTs(for: collectionSlug)
    }
}
