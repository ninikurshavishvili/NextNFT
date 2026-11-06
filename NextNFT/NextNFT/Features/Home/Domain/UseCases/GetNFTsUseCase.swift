//
//  GetNFTsUseCase.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 04.01.26.
//

import Foundation

final class GetNFTsUseCase: Sendable {
    private let repository: NFTRepositoryProtocol

    init(repository: NFTRepositoryProtocol) {
        self.repository = repository
    }

    func execute(for collectionSlug: String) async throws -> [NFT] {
        let nfts = try await repository.getNFTs(for: collectionSlug)
        return nfts.filter(\.isDisplayable)
    }
}
