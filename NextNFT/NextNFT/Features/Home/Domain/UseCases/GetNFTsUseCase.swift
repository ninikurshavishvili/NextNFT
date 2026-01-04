//
//  GetNFTsUseCase.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 04.01.26.
//

import Foundation

final class GetNFTsUseCase {
    private let repository: HomeRepositoryProtocol

    init(repository: HomeRepositoryProtocol = HomeRepository()) {
        self.repository = repository
    }

    func execute(for collectionSlug: String) async throws -> [NFT] {
        let nfts = try await repository.getNFTs(for: collectionSlug)

        return nfts
            .filter { nft in
                let hasImage =
                    !(nft.displayImageURL?.isEmpty ?? true) ||
                    !(nft.imageURL?.isEmpty ?? true)

                let hasName = !(nft.name?.isEmpty ?? true)
                let isValid = !(nft.isDisabled ?? false)

                return hasImage && hasName && isValid
            }
            .map { $0 }
    }
}
