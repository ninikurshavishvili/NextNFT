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
    
    private let getNFTsUseCase: GetNFTsUseCase
    
    init(getNFTsUseCase: GetNFTsUseCase = GetNFTsUseCase()) {
        self.getNFTsUseCase = getNFTsUseCase
    }
    
    func loadNFTs(for collectionSlug: String) async {
        isLoading = true
        errorMessage = nil
        
        do {
            nfts = try await getNFTsUseCase.execute(for: collectionSlug)
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
}
