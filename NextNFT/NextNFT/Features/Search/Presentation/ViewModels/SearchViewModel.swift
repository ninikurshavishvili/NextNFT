//
//  SearchViewModel.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 02.01.26.
//

import Foundation
import Combine

@MainActor
final class SearchViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var searchText = ""
    @Published var collections: [NFTCollection] = []
    @Published var nfts: [NFT] = []
    @Published var recentCollections: [NFTCollection] = []

    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var searchType: SearchType = .collections
    
    // MARK: - Private Properties
    private let searchCollectionsUseCase: SearchCollectionsUseCase
    private let searchNFTsUseCase: SearchNFTsUseCase
    private var searchTask: Task<Void, Never>?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initialization
    init(
        searchCollectionsUseCase: SearchCollectionsUseCase = SearchCollectionsUseCase(),
        searchNFTsUseCase: SearchNFTsUseCase = SearchNFTsUseCase()
    ) {
        self.searchCollectionsUseCase = searchCollectionsUseCase
        self.searchNFTsUseCase = searchNFTsUseCase
        
        setupSearchDebouncing()
        loadRecentCollections()
    }
    
    // MARK: - Public Methods
    func performSearch() async {
        guard !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            clearResults()
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        do {
            switch searchType {
            case .collections:
                collections = try await searchCollectionsUseCase.execute(query: searchText)
                nfts = []
            case .nfts:
                nfts = try await searchNFTsUseCase.execute(query: searchText)
                collections = []
            }
        } catch {
            handleError(error)
        }
        
        isLoading = false
    }
    
    func clearSearch() {
        searchText = ""
        clearResults()
    }
    
    func selectSearchType(_ type: SearchType) {
        searchType = type
        Task {
            await performSearch()
        }
    }
    
    // MARK: - Private Methods
    private func setupSearchDebouncing() {
        $searchText
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.triggerSearch()
            }
            .store(in: &cancellables)
    }
    
    private func triggerSearch() {
        searchTask?.cancel()
        searchTask = Task {
            await performSearch()
        }
    }
    
    private func clearResults() {
        collections = []
        nfts = []
        errorMessage = nil
    }
    
    private func handleError(_ error: Error) {
        errorMessage = error.localizedDescription
        print("Search error: \(error)")
        collections = []
        nfts = []
    }
    private func loadRecentCollections() {
        // TEMP: mock data (later replace with cache / API)
        recentCollections = [
            NFTCollection(
                collection: "impostors-genesis",
                name: "Impostors Genesis",
                description: nil,
                imageURL: "https://picsum.photos/400",
                bannerImageURL: nil,
                owner: nil,
                category: nil,
                openseaURL: nil,
                totalSupply: nil,
                createdDate: nil
            )
        ]
    }

}

// MARK: - Search Type
enum SearchType {
    case collections
    case nfts
    
    var title: String {
        switch self {
        case .collections:
            return "Collections"
        case .nfts:
            return "NFTs"
        }
    }
}
