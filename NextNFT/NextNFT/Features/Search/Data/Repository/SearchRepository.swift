//
//  SearchRepository.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 02.01.26.
//

final class SearchRepository: SearchRepositoryProtocol {

    private let dataSource: SearchRemoteDataSourceProtocol

    init(dataSource: SearchRemoteDataSourceProtocol = OpenSeaRemoteDataSource()) {
        self.dataSource = dataSource
    }

    func searchCollections(query: String) async throws -> [NFTCollection] {
        let dtos = try await dataSource.searchCollections(query: query)
        return dtos.map { $0.toDomain() }
    }

    func searchNFTs(query: String) async throws -> [NFT] {
        let dtos = try await dataSource.searchNFTs(query: query)
        return dtos.map { $0.toDomain() }
    }
}
