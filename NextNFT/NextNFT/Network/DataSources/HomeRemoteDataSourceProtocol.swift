//
//  OpenSeaDataSourceProtocol.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 15.12.25.
//


protocol HomeRemoteDataSourceProtocol {
    func fetchCollections(chain: String, limit: Int) async throws -> [CollectionDTO]
    func fetchNFTs(collectionSlug: String, limit: Int) async throws -> [NFTDTO]
}

extension HomeRemoteDataSourceProtocol {
    func fetchCollections(chain: String = "ethereum", limit: Int = 10) async throws -> [CollectionDTO] {
        try await fetchCollections(chain: chain, limit: limit)
    }
    
    func fetchNFTs(collectionSlug: String, limit: Int = 10) async throws -> [NFTDTO] {
        try await fetchNFTs(collectionSlug: collectionSlug, limit: limit)
    }
}
// Network/DataSources/OpenSeaRemoteDataSource.swift
class OpenSeaRemoteDataSource: HomeRemoteDataSourceProtocol, SearchRemoteDataSourceProtocol {
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
