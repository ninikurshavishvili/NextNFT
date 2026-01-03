//
//  SearchNFTsUseCase.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 02.01.26.
//

final class SearchNFTsUseCase {
    private let repository: SearchRepositoryProtocol

    init(repository: SearchRepositoryProtocol = SearchRepository()) {
        self.repository = repository
    }

    func execute(query: String) async throws -> [NFT] {
        try await repository.searchNFTs(query: query)
    }
}
