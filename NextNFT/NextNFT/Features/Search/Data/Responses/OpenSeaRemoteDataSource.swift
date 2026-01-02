//
//  OpenSeaRemoteDataSource.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 02.01.26.
//

func searchCollections(query: String) async throws -> [CollectionDTO] {
    let endpoint = OpenSeaEndpoint.searchCollections(query: query)
    let response: CollectionsResponseDTO = try await networkService.request(endpoint)
    return response.collections
}

func searchNFTs(query: String) async throws -> [NFTDTO] {
    let endpoint = OpenSeaEndpoint.searchNFTs(query: query)
    let response: NFTResponseDTO = try await networkService.request(endpoint)
    return response.nfts
}
