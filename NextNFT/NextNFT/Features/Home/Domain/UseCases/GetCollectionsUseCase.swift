//
//  GetCollectionsUseCase.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 15.12.25.
//

import Foundation
// Features/Home/Domain/UseCases/GetCollectionsUseCase.swift
// Features/Home/Domain/UseCases/GetCollectionsUseCase.swift
// Features/Home/Domain/UseCases/GetCollectionsUseCase.swift
class GetCollectionsUseCase {
    private let repository: HomeRepositoryProtocol
    
    init(repository: HomeRepositoryProtocol = HomeRepository()) {
        self.repository = repository
    }
    
    func execute() async throws -> [NFTCollection] {  // Change to concrete type
        return try await repository.getCollections() as? [NFTCollection] ?? []
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
