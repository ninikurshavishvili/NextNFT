//
//  NFTCarouselViewModel.swift
//  NextNFT
//
//  Created by Nini Kurshavishvili on 11.02.26.
//

import SwiftUI
import Combine

final class NFTCarouselViewModel: ObservableObject {
    @Published var nfts: [NFT] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var collection: NFTCollection?
    
    private let getNFTsUseCase: GetNFTsUseCase
    private let getCollectionBySlugUseCase: GetCollectionBySlugUseCase
    
    init(
        getNFTsUseCase: GetNFTsUseCase = GetNFTsUseCase(),
        getCollectionBySlugUseCase: GetCollectionBySlugUseCase = GetCollectionBySlugUseCase()
    ) {
        self.getNFTsUseCase = getNFTsUseCase
        self.getCollectionBySlugUseCase = getCollectionBySlugUseCase
    }
    
    @MainActor
    func loadNFTs(for collectionSlug: String) async {
        isLoading = true
        errorMessage = nil
        
        print("🔄 Loading NFTs for collection: \(collectionSlug)")
        
        do {
            // Load NFTs and collection details in parallel
            async let nftsTask = getNFTsUseCase.execute(for: collectionSlug)
            async let collectionTask = getCollectionBySlugUseCase.execute(for: collectionSlug)
            
            let (fetchedNFTs, fetchedCollection) = try await (nftsTask, collectionTask)
            
            print("✅ Fetched \(fetchedNFTs.count) NFTs")
            
            // IMPORTANT: Set the NFTs first
            self.nfts = fetchedNFTs
            
            // Then handle the collection
            if let fetchedCollection = fetchedCollection {
                self.collection = fetchedCollection
                print("✅ Found collection: \(fetchedCollection.name)")
            } else {
                print("⚠️ Collection not found for slug: \(collectionSlug), using fallback")
                // Create a fallback collection with the slug so cards still show
                self.collection = NFTCollection(
                    collection: collectionSlug,
                    name: collectionSlug.replacingOccurrences(of: "-", with: " ").capitalized,
                    description: "Part of the \(collectionSlug.replacingOccurrences(of: "-", with: " ")) collection",
                    imageURL: nil,
                    bannerImageURL: nil,
                    owner: nil,
                    category: nil,
                    openseaURL: nil,
                    totalSupply: nil,
                    createdDate: nil
                )
            }
            
            // Verify we have everything
            if fetchedNFTs.isEmpty {
                print("⚠️ No NFTs returned for this collection")
            }
            
        } catch {
            self.errorMessage = error.localizedDescription
            print("❌ Error loading NFTs: \(error)")
        }
        
        isLoading = false
    }
}
