//
//  TestDoubles.swift
//  NextNFTTests
//

import Foundation
@testable import NextNFT

// MARK: - Fixtures

extension NFT {
    static func fixture(
        identifier: String = "1",
        collection: String = "test-collection",
        name: String? = "Test NFT #1",
        imageURL: String? = "https://example.com/nft.png",
        displayImageURL: String? = nil,
        isDisabled: Bool? = false
    ) -> NFT {
        NFT(
            identifier: identifier,
            collection: collection,
            contract: nil,
            tokenStandard: nil,
            name: name,
            description: nil,
            imageURL: imageURL,
            displayImageURL: displayImageURL,
            displayAnimationURL: nil,
            metadataURL: nil,
            openseaURL: nil,
            updatedAt: nil,
            isDisabled: isDisabled,
            isNsfw: false
        )
    }
}

extension NFTCollection {
    static func fixture(
        slug: String = "test-collection",
        name: String = "Test Collection",
        imageURL: String? = "https://example.com/collection.png",
        description: String? = nil,
        totalSupply: Int? = nil
    ) -> NFTCollection {
        NFTCollection(
            collection: slug,
            name: name,
            description: description,
            imageURL: imageURL,
            bannerImageURL: nil,
            owner: nil,
            category: nil,
            openseaURL: nil,
            totalSupply: totalSupply,
            createdDate: nil
        )
    }
}

struct TestError: LocalizedError {
    var errorDescription: String? { "Something broke" }
}

// MARK: - Stub repositories

struct StubNFTRepository: NFTRepositoryProtocol {
    var collections: Result<[NFTCollection], Error> = .success([])
    /// NFTs per collection slug; slugs not listed return no NFTs.
    var nftsBySlug: [String: Result<[NFT], Error>] = [:]

    func getCollections() async throws -> [NFTCollection] {
        try collections.get()
    }

    func getNFTs(for collectionSlug: String) async throws -> [NFT] {
        try nftsBySlug[collectionSlug]?.get() ?? []
    }
}

struct StubSearchRepository: SearchRepositoryProtocol {
    var collections: Result<[NFTCollection], Error> = .success([])
    var nfts: Result<[NFT], Error> = .success([])

    func searchCollections(query: String) async throws -> [NFTCollection] {
        try collections.get()
    }

    func searchNFTs(query: String) async throws -> [NFT] {
        try nfts.get()
    }
}
