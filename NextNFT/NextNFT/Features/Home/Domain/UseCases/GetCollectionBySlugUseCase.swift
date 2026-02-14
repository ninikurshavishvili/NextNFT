//
//  GetCollectionBySlugUseCase.swift
//  NextNFT
//
//  Created by Nini Kurshavishvili on 14.02.26.
//

import Foundation

final class GetCollectionBySlugUseCase {
    private let repository: HomeRepositoryProtocol
    
    init(repository: HomeRepositoryProtocol = HomeRepository()) {
        self.repository = repository
    }
    
    func execute(for slug: String) async throws -> NFTCollection? {
        print("🔍 Fetching collection with slug: \(slug)")
        let collections = try await repository.getCollections()
        
        // Try exact match first
        if let exactMatch = collections.first(where: { $0.collection == slug }) {
            print("✅ Found exact match: \(exactMatch.name)")
            return exactMatch
        }
        
        // Try case-insensitive match
        if let caseInsensitiveMatch = collections.first(where: { $0.collection.lowercased() == slug.lowercased() }) {
            print("✅ Found case-insensitive match: \(caseInsensitiveMatch.name)")
            return caseInsensitiveMatch
        }
        
        // Try partial match
        if let partialMatch = collections.first(where: { $0.collection.contains(slug) || slug.contains($0.collection) }) {
            print("✅ Found partial match: \(partialMatch.name)")
            return partialMatch
        }
        
        print("❌ No collection found with slug: \(slug)")
        return nil
    }
}
