//
//  GetCollectionsUseCase.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 15.12.25.
//


import Foundation

class GetCollectionsUseCase {
    private let repository: HomeRepositoryProtocol
    
    init(repository: HomeRepositoryProtocol = HomeRepository()) {
        self.repository = repository
    }
    
    func execute() async throws -> [NFTCollection] {
        print("📥 GetCollectionsUseCase: Fetching collections")
        let collections = try await repository.getCollections()
        print("📦 Raw collections count: \(collections.count)")
        
        // Less aggressive filtering - keep more collections
        let promisingCollections = filterPromisingCollections(collections)
        print("🎯 After basic filter: \(promisingCollections.count) collections")
        
        // Check for NFTs in parallel (but don't filter out collections without NFTs yet)
        let collectionsWithNFTs = await checkCollectionsForNFTs(promisingCollections)
        print("✅ Collections with NFTs: \(collectionsWithNFTs.count)")
        
        // Return up to 20 collections instead of 10
        return Array(collectionsWithNFTs.prefix(20))
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
    
    private func checkCollectionsForNFTs(_ collections: [NFTCollection]) async -> [NFTCollection] {
        await withTaskGroup(of: (NFTCollection, Int).self) { group in
            var validCollections: [NFTCollection] = []
            
            // Start all checks in parallel
            for collection in collections {
                group.addTask {
                    do {
                        let nfts = try await self.repository.getNFTs(for: collection.collection)
                        return (collection, nfts.count)
                    } catch {
                        return (collection, 0)
                    }
                }
            }
            
            // Collect results as they complete
            for await (collection, nftCount) in group {
                print("📊 Collection '\(collection.name)' has \(nftCount) NFTs")
                
                // Only require at least 1 NFT instead of 3
                if nftCount >= 1 {
                    validCollections.append(collection)
                }
                
                // Early exit if we have enough (increased to 20)
                if validCollections.count >= 20 {
                    group.cancelAll()
                    break
                }
            }
            
            return validCollections
        }
    }
}

