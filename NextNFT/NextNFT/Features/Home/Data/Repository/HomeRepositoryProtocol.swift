//
//  HomeRepositoryProtocol.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 15.12.25.
//

// Features/Home/Domain/Repositories/HomeRepositoryProtocol.swift
protocol HomeRepositoryProtocol {
    func getCollections() async throws -> [CollectionModel]
    func getNFTs(for collectionSlug: String) async throws -> [NFTModel]
}

// Features/Home/Data/Repositories/HomeRepository.swift
class HomeRepository: HomeRepositoryProtocol {
    private let dataSource: OpenSeaDataSourceProtocol
    
    init(dataSource: OpenSeaDataSourceProtocol = OpenSeaRemoteDataSource()) {
        self.dataSource = dataSource
    }
    
    func getCollections() async throws -> [CollectionModel] {
        return try await dataSource.fetchCollections()
    }
    
    func getNFTs(for collectionSlug: String) async throws -> [NFTModel] {
        return try await dataSource.fetchNFTs(collectionSlug: collectionSlug)
    }
}
