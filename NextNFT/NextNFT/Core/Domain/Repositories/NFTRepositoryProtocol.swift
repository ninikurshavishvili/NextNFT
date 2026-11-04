//
//  NFTRepositoryProtocol.swift
//  NextNFT
//

/// Shared source of collections and NFTs, used by Home and Search.
protocol NFTRepositoryProtocol: Sendable {
    func getCollections() async throws -> [NFTCollection]
    func getNFTs(for collectionSlug: String) async throws -> [NFT]
}
