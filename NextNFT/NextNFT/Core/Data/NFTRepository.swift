//
//  NFTRepository.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 15.12.25.
//

final class NFTRepository: NFTRepositoryProtocol {

    private let dataSource: NFTRemoteDataSourceProtocol

    init(dataSource: NFTRemoteDataSourceProtocol) {
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
