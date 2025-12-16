//
//  CollectionViewModel.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 25.10.25.
//

import Foundation

class CollectionsViewModel: ObservableObject {
    @Published var collections: [NFTCollection] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    func fetchCollections() {
        isLoading = true
        errorMessage = nil

        NetworkManager.shared.getCollections { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let collections):
                    self?.collections = collections
                    print("Fetched Collections:", collections)
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    
                }
            }
        }
    }
}
