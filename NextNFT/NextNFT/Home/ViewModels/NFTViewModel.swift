//
//  NFTViewModel.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 27.08.25.
//

import Foundation
import FirebaseDatabase
import FirebaseCore

class NFTViewModel: ObservableObject {
    @Published var nfts: [NFT] = []
    @Published var errorMessage: String? = nil
    
    private let service: NFTFirebaseServiceProtocol
    
    init(service: NFTFirebaseServiceProtocol = NFTFirebaseService()) {
        self.service = service
    }
    
    func fetchNFTs() {
        service.fetchNFTs { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let nfts):
                    self?.nfts = nfts
                    print("✅ Successfully fetched NFTs:", nfts)
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    print("❌ Error fetching NFTs:", error)
                }
            }
        }
    }
}

