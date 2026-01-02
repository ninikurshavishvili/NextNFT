//
//  SearchCollectionsUseCase.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 02.01.26.
//

final class SearchCollectionsUseCase {
    private let repository: SearchRepositoryProtocol

    init(repository: SearchRepositoryProtocol = SearchRepository()) {
        self.repository = repository
    }

    func execute(query: String) async throws -> [NFTCollection] {
        try await repository.searchCollections(query: query)
    }
}
