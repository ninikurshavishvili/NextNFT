//
//  CollectionNFTsViewModel.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 03.01.26.
//


import Foundation

@MainActor
final class CollectionNFTsViewModel: ObservableObject {
    @Published var nfts: [NFT] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let getNFTsUseCase: GetNFTsUseCase

    init(getNFTsUseCase: GetNFTsUseCase = GetNFTsUseCase()) {
        self.getNFTsUseCase = getNFTsUseCase
    }

    func load(collectionSlug: String) async {
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
