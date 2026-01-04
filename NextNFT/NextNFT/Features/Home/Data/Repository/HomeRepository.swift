//
//  HomeRepository.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 15.12.25.
//



protocol HomeRepositoryProtocol {
    func getCollections() async throws -> [NFTCollection]
    func getNFTs(for collectionSlug: String) async throws -> [NFT]
}

final class HomeRepository: HomeRepositoryProtocol {

    private let dataSource: HomeRemoteDataSourceProtocol

    init(dataSource: HomeRemoteDataSourceProtocol = OpenSeaRemoteDataSource()) {
        self.dataSource = dataSource
    }

    func getCollections() async throws -> [NFTCollection] {
        let dtos = try await dataSource.fetchCollections()
        return dtos.map { $0.toDomain() }
    }

    func getNFTs(for collectionSlug: String) async throws -> [NFT] {
        let dtos = try await dataSource.fetchNFTs(collectionSlug: collectionSlug)
        return dtos.map { $0.toDomain() }
    }
    
}
