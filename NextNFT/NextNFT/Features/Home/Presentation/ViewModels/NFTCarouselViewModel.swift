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
    private let getCollectionsUseCase: GetCollectionsUseCase
    
    init(
        getNFTsUseCase: GetNFTsUseCase = GetNFTsUseCase(),
        getCollectionsUseCase: GetCollectionsUseCase = GetCollectionsUseCase()
    ) {
        self.getNFTsUseCase = getNFTsUseCase
        self.getCollectionsUseCase = getCollectionsUseCase
    }
    
    @MainActor
    func loadNFTs(for collectionSlug: String) async {
        isLoading = true
        errorMessage = nil
        
        print("🔄 Loading NFTs for collection: \(collectionSlug)")
        
        do {
            // Load both NFTs and collections in parallel
            async let nftsTask = getNFTsUseCase.execute(for: collectionSlug)
            async let collectionsTask = getCollectionsUseCase.execute()
            
            let (fetchedNFTs, allCollections) = try await (nftsTask, collectionsTask)
            
            print("✅ Fetched \(fetchedNFTs.count) NFTs")
            print("✅ Fetched \(allCollections.count) collections")
            
            // Find the specific collection
            self.collection = allCollections.first { $0.collection == collectionSlug }
            
            if self.collection != nil {
                print("✅ Found collection: \(self.collection?.name ?? "unknown")")
            } else {
                print("❌ Collection not found with slug: \(collectionSlug)")
                print("Available collections: \(allCollections.map { $0.collection })")
            }
            
            self.nfts = fetchedNFTs
            
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
