//
//  NFTViewModel.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 26.10.25.
//

import Foundation

class NFTViewModel: ObservableObject {
    @Published var nfts: [NFT] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    func fetchNFTs(for slug: String) {
        isLoading = true
        errorMessage = nil
        
        NetworkManager.shared.getNFTs(for: slug) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false

                switch result {
                case .success(let nftList):
                    self?.nfts = nftList
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}


