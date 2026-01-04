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
        let collections: [NFTCollection] = try await repository.getCollections()

        return collections
            .filter { collection in
                let hasImage = !(collection.imageURL?.isEmpty ?? true)
                let hasBanner = !(collection.bannerImageURL?.isEmpty ?? true)
                let hasDescription = !(collection.description?.isEmpty ?? true)

                return hasImage && hasBanner && hasDescription
            }

            .prefix(12)
            .map { $0 }
    }


}


