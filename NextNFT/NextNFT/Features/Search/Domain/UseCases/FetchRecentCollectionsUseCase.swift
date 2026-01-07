//
//  FetchRecentCollectionsUseCase.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 07.01.26.
//


final class FetchRecentCollectionsUseCase {
    private let repository: HomeRepositoryProtocol

    init(repository: HomeRepositoryProtocol = HomeRepository()) {
        self.repository = repository
    }

    func execute() async throws -> [NFTCollection] {
        try await repository.fetchCollections()
    }
}
