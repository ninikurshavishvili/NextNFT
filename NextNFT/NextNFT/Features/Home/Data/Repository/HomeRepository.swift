//
//  HomeRepository.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 15.12.25.
//


// Features/Home/Data/Repositories/HomeRepository.swift
class HomeRepository: HomeRepositoryProtocol {
    private let dataSource: OpenSeaDataSourceProtocol
    
    init(dataSource: OpenSeaDataSourceProtocol = OpenSeaRemoteDataSource()) {
        self.dataSource = dataSource
    }
    
    func getCollections() async throws -> [Collection] {
        let dtos = try await dataSource.fetchCollections()
        return dtos.compactMap { $0.toDomain() }
    }
    
    func getNFTs(for collectionSlug: String) async throws -> [NFT] {
        let dtos = try await dataSource.fetchNFTs(collectionSlug: collectionSlug)
        return dtos.compactMap { $0.toDomain() }
    }
}