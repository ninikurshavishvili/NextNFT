//
//  GetTrendingCollectionsUseCase.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 15.12.25.
//


import Foundation
import OSLog

final class GetTrendingCollectionsUseCase: Sendable {
    private let repository: NFTRepositoryProtocol

    init(repository: NFTRepositoryProtocol) {
        self.repository = repository
    }

    func execute() async throws -> [TrendingCollection] {
        let collections = try await repository.getCollections()
        Logger.home.debug("Raw collections count: \(collections.count)")
        
        // Less aggressive filtering - keep more collections
        let promisingCollections = filterPromisingCollections(collections)
        Logger.home.debug("After basic filter: \(promisingCollections.count) collections")
        
        // Load each collection's NFTs in parallel; collections without any are dropped
        let trendingCollections = await loadNFTPreviews(for: promisingCollections)
        Logger.home.debug("Collections with NFTs: \(trendingCollections.count)")

        // Failed NFT requests count as "no NFTs", so surface cancellation to the caller
        try Task.checkCancellation()

        // Return up to 20 collections instead of 10
        return Array(trendingCollections.prefix(20))
    }
    
    private func filterPromisingCollections(_ collections: [NFTCollection]) -> [NFTCollection] {
        collections
            .filter { collection in
                // Basic validation only - no popularity score filter
                let hasValidImage = (collection.imageURL?.isEmpty == false)
                let hasValidName = !collection.name.isEmpty
                let hasValidSlug = !collection.collection.isEmpty
                
                // Only filter out collections missing basic requirements
                return hasValidImage && hasValidName && hasValidSlug
            }
            .sorted { lhs, rhs in
                // Sort by potential popularity (but keep all)
                calculatePopularityScore(for: lhs) > calculatePopularityScore(for: rhs)
            }
    }
    
    private func calculatePopularityScore(for collection: NFTCollection) -> Double {
        var score: Double = 0.1 // Base score for all collections
        
        // Check name for popular keywords (with weights)
        let name = collection.name.lowercased()
        let popularKeywords: [(String, Double)] = [
            ("ape", 0.8), ("punk", 0.9), ("azuki", 0.7),
            ("doodle", 0.7), ("cat", 0.3), ("dog", 0.3),
            ("alien", 0.5), ("god", 0.6), ("bird", 0.3),
            ("bayc", 0.9), ("cryptopunks", 0.9), ("mfer", 0.6),
            ("noun", 0.5), ("bean", 0.4), ("milady", 0.6)
        ]
        
        for (keyword, weight) in popularKeywords {
            if name.contains(keyword) {
                score += weight
            }
        }
        
        // Bonus for having metadata
        if collection.description?.isEmpty == false { score += 0.2 }
        if collection.openseaURL?.isEmpty == false { score += 0.2 }
        if collection.totalSupply ?? 0 > 100 { score += 0.3 }
        if collection.totalSupply ?? 0 > 1000 { score += 0.3 }
        
        return min(score, 2.0) // Allow higher scores
    }
    
    /// Fetches every collection's NFTs in parallel and keeps the collections
    /// that have displayable NFTs, in their original (popularity) order.
    /// The NFTs are returned too, so the Trending rows don't fetch them again.
    private func loadNFTPreviews(for collections: [NFTCollection]) async -> [TrendingCollection] {
        let nftsBySlug = await withTaskGroup(of: (String, [NFT]).self) { group in
            for collection in collections {
                group.addTask {
                    let nfts = (try? await self.repository.getNFTs(for: collection.collection)) ?? []
                    return (collection.collection, nfts.filter(\.isDisplayable))
                }
            }

            var results: [String: [NFT]] = [:]
            for await (slug, nfts) in group {
                Logger.home.debug("Collection '\(slug)' has \(nfts.count) NFTs")
                results[slug] = nfts
            }
            return results
        }

        return collections.compactMap { collection in
            guard let nfts = nftsBySlug[collection.collection], !nfts.isEmpty else { return nil }
            return TrendingCollection(collection: collection, nfts: nfts)
        }
    }
}

