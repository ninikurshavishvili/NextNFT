//
//  HomeViewModel.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 03.01.26.
//

import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var collections: [NFTCollection] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let getCollectionsUseCase: GetCollectionsUseCase

    init(getCollectionsUseCase: GetCollectionsUseCase = GetCollectionsUseCase()) {
        self.getCollectionsUseCase = getCollectionsUseCase
    }

    func load() async {
        isLoading = true
        errorMessage = nil

        do {
            collections = try await getCollectionsUseCase.execute()
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
