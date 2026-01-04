//
//  GetCollectionsUseCase.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 15.12.25.
//


//TODO: - need to filter NFTs

import Foundation

class GetCollectionsUseCase {
    private let repository: HomeRepositoryProtocol
    
    init(repository: HomeRepositoryProtocol = HomeRepository()) {
        self.repository = repository
    }
    
    func execute() async throws -> [NFTCollection] {
        let collections: [NFTCollection] = try await repository.getCollections()
        
        // Filter collections that likely have NFTs based on metadata
        let promisingCollections = collections
            .filter { collection in
                // Collections with these traits usually have NFTs
                let hasImage = !(collection.imageURL?.isEmpty ?? true)
                let hasDescription = !(collection.description?.isEmpty ?? true)
                let hasOpenseaURL = !(collection.openseaURL?.isEmpty ?? true)
                
                // Check for popular collection keywords in name/description
                let name = collection.name.lowercased()
                let description = collection.description?.lowercased() ?? ""
                
                let isPopular = name.contains("ape") ||
                               name.contains("punk") ||
                               name.contains("azuki") ||
                               name.contains("doodle") ||
                               name.contains("clone") ||
                               name.contains("penguin") ||
                               name.contains("cat") ||
                               name.contains("dog") ||
                               name.contains("alien") ||
                               name.contains("goblin") ||
                               name.contains("god") ||
                               name.contains("bird") ||
                               description.contains("nft") ||
                               description.contains("collection") ||
                               description.contains("token")
                
                return hasImage && hasDescription && hasOpenseaURL && isPopular
            }
            .prefix(20) // Check more initially
        
        var collectionsWithNFTs: [NFTCollection] = []
        
        for collection in promisingCollections.prefix(8) {
            do {
                let nfts = try await repository.getNFTs(for: collection.collection)
                if nfts.count >= 5 {
                    collectionsWithNFTs.append(collection)
                    
                    if collectionsWithNFTs.count >= 10 {
                        break
                    }
                }
            } catch {
                continue
            }
        }
        
        return collectionsWithNFTs
    }
}


