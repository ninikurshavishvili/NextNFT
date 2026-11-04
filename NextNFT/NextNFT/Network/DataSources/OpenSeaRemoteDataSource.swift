//
//  OpenSeaRemoteDataSource.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 15.12.25.
//

class OpenSeaRemoteDataSource: NFTRemoteDataSourceProtocol, SearchRemoteDataSourceProtocol {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService.shared) {
        self.networkService = networkService
    }
    
    func fetchCollections(chain: String, limit: Int) async throws -> [CollectionDTO] {
        let endpoint = OpenSeaEndpoint.collections(chain: chain, limit: limit)
        let response: CollectionsResponseDTO = try await networkService.request(endpoint)
        return response.collections
    }
    
    func fetchNFTs(collectionSlug: String, limit: Int) async throws -> [NFTDTO] {
        let endpoint = OpenSeaEndpoint.nfts(collectionSlug: collectionSlug, limit: limit)
        let response: NFTResponseDTO = try await networkService.request(endpoint)
        return response.nfts
    }
    
    // MARK: - Search Methods
    func searchCollections(query: String, limit: Int) async throws -> [CollectionDTO] {
        let endpoint = OpenSeaEndpoint.searchCollections(query: query, limit: limit)
        let response: CollectionsResponseDTO = try await networkService.request(endpoint)
        return response.collections
    }
    
    func searchNFTs(query: String, limit: Int) async throws -> [NFTDTO] {
        let endpoint = OpenSeaEndpoint.searchNFTs(query: query, limit: limit)
        let response: NFTResponseDTO = try await networkService.request(endpoint)
        return response.nfts
    }
}
