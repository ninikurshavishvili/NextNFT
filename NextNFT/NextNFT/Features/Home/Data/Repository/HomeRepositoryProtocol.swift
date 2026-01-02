//
//  HomeRepositoryProtocol.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 15.12.25.
//

// Features/Home/Domain/Repositories/HomeRepositoryProtocol.swift
// Update your repository protocol to return [NFTCollection]
// Features/Home/Domain/Repositories/HomeRepositoryProtocol.swift

//// Features/Home/Data/Repositories/HomeRepository.swift
//class HomeRepository: HomeRepositoryProtocol {
//    private let dataSource: OpenSeaDataSourceProtocol
//    
//    init(dataSource: OpenSeaDataSourceProtocol = OpenSeaRemoteDataSource()) {
//        self.dataSource = dataSource
//    }
//    
//    func getCollections() async throws -> [NFTCollection] {  // Change to concrete type
//        let dtos = try await dataSource.fetchCollections()
//        return dtos.compactMap { $0.toDomain() }
//    }
//    
//    func getNFTs(for collectionSlug: String) async throws -> [NFT] {
//        let dtos = try await dataSource.fetchNFTs(collectionSlug: collectionSlug)
//        return dtos.compactMap { $0.toDomain() }
//    }
//}
