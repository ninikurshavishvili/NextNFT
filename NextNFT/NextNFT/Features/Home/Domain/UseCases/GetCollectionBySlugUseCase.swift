//
//  GetCollectionBySlugUseCase.swift
//  NextNFT
//
//  Created by Nini Kurshavishvili on 14.02.26.
//

import Foundation
import OSLog

final class GetCollectionBySlugUseCase {
    private let repository: NFTRepositoryProtocol
    
    init(repository: NFTRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(for slug: String) async throws -> NFTCollection? {
        Logger.home.debug("Fetching collection with slug: \(slug)")
        let collections = try await repository.getCollections()
        
        // Try exact match first
        if let exactMatch = collections.first(where: { $0.collection == slug }) {
            Logger.home.debug("Found exact match: \(exactMatch.name)")
            return exactMatch
        }
        
        // Try case-insensitive match
        if let caseInsensitiveMatch = collections.first(where: { $0.collection.lowercased() == slug.lowercased() }) {
            Logger.home.debug("Found case-insensitive match: \(caseInsensitiveMatch.name)")
            return caseInsensitiveMatch
        }
        
        // Try partial match
        if let partialMatch = collections.first(where: { $0.collection.contains(slug) || slug.contains($0.collection) }) {
            Logger.home.debug("Found partial match: \(partialMatch.name)")
            return partialMatch
        }
        
        Logger.home.notice("No collection found with slug: \(slug)")
        return nil
    }
}
