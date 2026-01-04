//
//  GetCollectionsUseCase.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 15.12.25.
//


//TODO: - need to filter NFTs
//1

import Foundation

// Features/Home/Domain/UseCases/GetCollectionsUseCase.swift
class GetCollectionsUseCase {
    private let repository: HomeRepositoryProtocol
    
    init(repository: HomeRepositoryProtocol = HomeRepository()) {
        self.repository = repository
    }
    
    func execute() async throws -> [NFTCollection] {
        let collections = try await repository.getCollections()
        
        // JUST KEEP EVERYTHING for now, but sort them
        return collections.sorted { $0.name < $1.name }
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
