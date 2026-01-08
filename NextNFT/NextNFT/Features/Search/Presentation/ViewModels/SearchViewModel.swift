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
    @Published var isLoadingRecent = false
    @Published var errorMessage: String?
    @Published var recentErrorMessage: String?
    @Published var searchType: SearchType = .collections
    
    // MARK: - Private Properties
    private let searchCollectionsUseCase: SearchCollectionsUseCase
    private let searchNFTsUseCase: SearchNFTsUseCase
    private let fetchRecentCollectionsUseCase: FetchRecentCollectionsUseCase
    private var searchTask: Task<Void, Never>?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initialization
    init(
        searchCollectionsUseCase: SearchCollectionsUseCase = SearchCollectionsUseCase(),
        searchNFTsUseCase: SearchNFTsUseCase = SearchNFTsUseCase(),
        fetchRecentCollectionsUseCase: FetchRecentCollectionsUseCase = FetchRecentCollectionsUseCase()
    ) {
        self.searchCollectionsUseCase = searchCollectionsUseCase
        self.searchNFTsUseCase = searchNFTsUseCase
        self.fetchRecentCollectionsUseCase = fetchRecentCollectionsUseCase
        
        setupSearchDebouncing()
        
        Task {
            await loadRecentCollections()
        }
    }
    
    // MARK: - Public Methods
    func performSearch() async {
        guard !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            clearResults()
            // Don't reload recent collections here - they're already loaded on init
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
    
    func refreshRecentCollections() async {
        await loadRecentCollections()
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
        errorMessage = "Search failed: \(error.localizedDescription)"
        collections = []
        nfts = []
    }
    
    private func loadRecentCollections() async {
        isLoadingRecent = true
        recentErrorMessage = nil
        
        do {
            // Use the FetchRecentCollectionsUseCase to get recent collections
            recentCollections = try await fetchRecentCollectionsUseCase.execute()
        } catch {
            recentErrorMessage = "Failed to load recent collections: \(error.localizedDescription)"
            // Fallback to mock data for development
            recentCollections = getMockRecentCollections()
        }
        
        isLoadingRecent = false
    }
    
    private func getMockRecentCollections() -> [NFTCollection] {
        return [
            NFTCollection(
                collection: "impostors-genesis",
                name: "Impostors Genesis",
                description: "A collection of genesis impostors",
                imageURL: "https://picsum.photos/400",
                bannerImageURL: nil,
                owner: nil,
                category: "art",
                openseaURL: nil,
                totalSupply: 10000,
                createdDate: nil
            ),
            NFTCollection(
                collection: "boredapeyachtclub",
                name: "Bored Ape Yacht Club",
                description: "10,000 unique Bored Ape NFTs",
                imageURL: "https://picsum.photos/401",
                bannerImageURL: nil,
                owner: nil,
                category: "pfp",
                openseaURL: nil,
                totalSupply: 10000,
                createdDate: nil
            ),
            NFTCollection(
                collection: "cryptopunks",
                name: "CryptoPunks",
                description: "10,000 unique collectible characters",
                imageURL: "https://picsum.photos/402",
                bannerImageURL: nil,
                owner: nil,
                category: "pfp",
                openseaURL: nil,
                totalSupply: 10000,
                createdDate: nil
            ),
            NFTCollection(
                collection: "doodles-official",
                name: "Doodles",
                description: "A community-driven collectibles project",
                imageURL: "https://picsum.photos/403",
                bannerImageURL: nil,
                owner: nil,
                category: "art",
                openseaURL: nil,
                totalSupply: 10000,
                createdDate: nil
            ),
            NFTCollection(
                collection: "clonex",
                name: "CLONE X - X TAKASHI MURAKAMI",
                description: "20,000 next-gen Avatars",
                imageURL: "https://picsum.photos/404",
                bannerImageURL: nil,
                owner: nil,
                category: "pfp",
                openseaURL: nil,
                totalSupply: 20000,
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
    
    var systemImage: String {
        switch self {
        case .collections:
            return "square.grid.2x2"
        case .nfts:
            return "photo"
        }
    }
}
