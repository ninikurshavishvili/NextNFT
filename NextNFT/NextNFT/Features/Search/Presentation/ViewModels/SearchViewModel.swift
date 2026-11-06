//
//  SearchViewModel.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 02.01.26.
//

import Foundation
import Observation

@MainActor
@Observable
final class SearchViewModel {
    struct Results: Equatable {
        var collections: [NFTCollection] = []
        var nfts: [NFT] = []
    }

    // MARK: - State
    var searchText = "" {
        didSet {
            guard searchText != oldValue else { return }
            scheduleSearch()
        }
    }
    private(set) var searchType: SearchType = .collections
    private(set) var resultsState: ViewState<Results> = .idle
    private(set) var recentState: ViewState<[NFTCollection]> = .idle

    // MARK: - Private Properties
    private let searchCollectionsUseCase: SearchCollectionsUseCase
    private let searchNFTsUseCase: SearchNFTsUseCase
    private let fetchRecentCollectionsUseCase: FetchRecentCollectionsUseCase
    /// How long typing has to pause before a search request goes out.
    private let debounce: Duration
    private var searchTask: Task<Void, Never>?

    // MARK: - Initialization
    init(
        searchCollectionsUseCase: SearchCollectionsUseCase,
        searchNFTsUseCase: SearchNFTsUseCase,
        fetchRecentCollectionsUseCase: FetchRecentCollectionsUseCase,
        debounce: Duration = .milliseconds(500)
    ) {
        self.searchCollectionsUseCase = searchCollectionsUseCase
        self.searchNFTsUseCase = searchNFTsUseCase
        self.fetchRecentCollectionsUseCase = fetchRecentCollectionsUseCase
        self.debounce = debounce
    }

    // MARK: - Public Methods
    func loadRecentCollectionsIfNeeded() async {
        guard recentState.needsLoad else { return }
        await loadRecentCollections()
    }

    func refreshRecentCollections() async {
        await loadRecentCollections()
    }

    func performSearch() async {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else {
            resultsState = .idle
            return
        }

        resultsState = .loading

        do {
            var results = Results()
            switch searchType {
            case .collections:
                results.collections = try await searchCollectionsUseCase.execute(query: query)
            case .nfts:
                results.nfts = try await searchNFTsUseCase.execute(query: query)
            }
            // A newer search may have started while this one was in flight
            try Task.checkCancellation()

            let isEmpty = results.collections.isEmpty && results.nfts.isEmpty
            resultsState = isEmpty ? .empty : .loaded(results)
        } catch where error.isCancellation {
            // Replaced by a newer search, which owns the state now
        } catch {
            resultsState = .failed(message: "Search failed: \(error.localizedDescription)")
        }
    }

    func clearSearch() {
        searchText = ""
        searchTask?.cancel()
        resultsState = .idle
    }

    func selectSearchType(_ type: SearchType) {
        searchType = type
        searchTask?.cancel()
        searchTask = Task { await performSearch() }
    }

    // MARK: - Private Methods
    private func scheduleSearch() {
        searchTask?.cancel()
        searchTask = Task { [weak self, debounce] in
            try? await Task.sleep(for: debounce)
            guard !Task.isCancelled else { return }
            await self?.performSearch()
        }
    }

    private func loadRecentCollections() async {
        recentState = .loading

        do {
            let collections = try await fetchRecentCollectionsUseCase.execute()
            recentState = collections.isEmpty ? .empty : .loaded(collections)
        } catch where error.isCancellation {
            recentState = .idle
        } catch {
            recentState = .failed(message: "Failed to load recent collections: \(error.localizedDescription)")
        }
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
