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
        
        do {
            // Load both NFTs and collection details in parallel
            async let nftsTask = getNFTsUseCase.execute(for: collectionSlug)
            async let collectionsTask = getCollectionsUseCase.execute()
            
            let (fetchedNFTs, allCollections) = try await (nftsTask, collectionsTask)
            
            // Find the specific collection
            self.collection = allCollections.first { $0.collection == collectionSlug }
            self.nfts = fetchedNFTs
            
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
}
