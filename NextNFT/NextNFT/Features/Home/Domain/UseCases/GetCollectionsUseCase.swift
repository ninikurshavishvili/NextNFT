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
        let collections = try await repository.getCollections()
        
        // Initial filtering (fast, local only)
        let promisingCollections = filterPromisingCollections(collections)
        
        // Check for NFTs in parallel
        let collectionsWithNFTs = await checkCollectionsForNFTs(promisingCollections)
        
        return Array(collectionsWithNFTs.prefix(10))
    }
    
    private func filterPromisingCollections(_ collections: [NFTCollection]) -> [NFTCollection] {
        collections
            .filter { collection in
                // Basic validation
                let hasValidImage = (collection.imageURL?.isEmpty == false)
                let hasValidName = !collection.name.isEmpty
                let hasValidSlug = !collection.collection.isEmpty
                
                // Score-based popularity detection
                let popularityScore = calculatePopularityScore(for: collection)
                
                return hasValidImage && hasValidName && hasValidSlug && popularityScore > 0.3
            }
            .sorted { lhs, rhs in
                // Sort by potential popularity
                calculatePopularityScore(for: lhs) > calculatePopularityScore(for: rhs)
            }
//            .prefix(15) // Limit for parallel checking
    }
    
    private func calculatePopularityScore(for collection: NFTCollection) -> Double {
        var score: Double = 0
        
        // Check name for popular keywords (with weights)
        let name = collection.name.lowercased()
        let popularKeywords: [(String, Double)] = [
            ("ape", 0.8), ("punk", 0.9), ("azuki", 0.7),
            ("doodle", 0.7), ("cat", 0.3), ("dog", 0.3),
            ("alien", 0.5), ("god", 0.6), ("bird", 0.3)
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
        
        return min(score, 1.0)
    }
    
    private func checkCollectionsForNFTs(_ collections: [NFTCollection]) async -> [NFTCollection] {
        await withTaskGroup(of: (NFTCollection, Bool).self) { group in
            var validCollections: [NFTCollection] = []
            
            // Start all checks in parallel
            for collection in collections {
                group.addTask {
                    do {
                        let nfts = try await self.repository.getNFTs(for: collection.collection)
                        let hasEnoughNFTs = nfts.count >= 3
                        return (collection, hasEnoughNFTs)
                    } catch {
                        return (collection, false)
                    }
                }
            }
            
            // Collect results as they complete
            for await (collection, hasNFTs) in group {
                if hasNFTs {
                    validCollections.append(collection)
                }
                
                // Early exit if we have enough
                if validCollections.count >= 10 {
                    group.cancelAll()
                    break
                }
            }
            
            return validCollections
        }
    }
}

