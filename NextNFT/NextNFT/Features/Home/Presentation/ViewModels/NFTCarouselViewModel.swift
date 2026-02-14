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
            
            // Set collection (create fallback if nil)
            if let fetchedCollection = fetchedCollection {
                self.collection = fetchedCollection
                print("✅ Found collection: \(fetchedCollection.name)")
            } else {
                print("⚠️ Collection not found, creating fallback")
                // Create a fallback collection with the slug
                self.collection = NFTCollection(
                    collection: collectionSlug,
                    name: collectionSlug.replacingOccurrences(of: "-", with: " ").capitalized,
                    description: "Collection description",
                    imageURL: nil,
                    bannerImageURL: nil,
                    owner: nil,
                    category: nil,
                    openseaURL: nil,
                    totalSupply: nil,
                    createdDate: nil
                )
            }
            
            self.nfts = fetchedNFTs
            
        } catch {
            self.errorMessage = error.localizedDescription
            print("❌ Error loading NFTs: \(error)")
        }
        
        isLoading = false
    }
}
