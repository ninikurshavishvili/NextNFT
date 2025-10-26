//
//  NFTViewModel.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 26.10.25.
//

import Foundation

class NFTViewModel: ObservableObject {
    @Published var nfts: [NFTModel] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    func fetchNFTs(for collectionSlug: String) {
        isLoading = true
        errorMessage = nil
        
        NetworkManager.shared.getNFTs(for: collectionSlug) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let nfts):
                    self?.nfts = nfts
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}

