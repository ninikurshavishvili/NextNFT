//
//  RemoteDataSourceProtocol.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 15.12.25.
//

protocol OpenSeaDataSourceProtocol {
    func fetchCollections(chain: String, limit: Int) async throws -> [CollectionDTO]
    func fetchNFTs(collectionSlug: String, limit: Int) async throws -> [NFTDTO]
}

// Network/DataSources/OpenSeaRemoteDataSource.swift
class OpenSeaRemoteDataSource: OpenSeaDataSourceProtocol {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService.shared) {
        self.networkService = networkService
    }
    
    func fetchCollections(chain: String = "ethereum", limit: Int = 10) async throws -> [CollectionDTO] {
        let endpoint = OpenSeaEndpoint(type: .getCollections(chain: chain, limit: limit))
        let response: CollectionsResponseDTO = try await networkService.request(endpoint)
        return response.collections
    }
    
    func fetchNFTs(collectionSlug: String, limit: Int = 10) async throws -> [NFTDTO] {
        let endpoint = OpenSeaEndpoint(type: .getNFTs(collectionSlug: collectionSlug, limit: limit))
        let response: NFTResponseDTO = try await networkService.request(endpoint)
        return response.nfts
    }
}
