//
//  ViewModelTests.swift
//  NextNFTTests
//

import Foundation
import Testing
@testable import NextNFT

@MainActor
struct HomeViewModelTests {

    private func makeViewModel(_ repository: StubNFTRepository) -> HomeViewModel {
        HomeViewModel(getTrendingCollectionsUseCase: GetTrendingCollectionsUseCase(repository: repository))
    }

    @Test func loadsTrendingCollections() async {
        let viewModel = makeViewModel(StubNFTRepository(
            collections: .success([.fixture(slug: "azuki")]),
            nftsBySlug: ["azuki": .success([.fixture()])]
        ))

        await viewModel.loadIfNeeded()

        #expect(viewModel.trendingState.value?.map(\.id) == ["azuki"])
    }

    @Test func isEmptyWhenNoCollectionHasNFTs() async {
        let viewModel = makeViewModel(StubNFTRepository(collections: .success([.fixture()])))

        await viewModel.load()

        #expect(viewModel.trendingState == .empty)
    }

    @Test func showsTheErrorMessageWhenLoadingFails() async {
        let viewModel = makeViewModel(StubNFTRepository(collections: .failure(TestError())))

        await viewModel.load()

        #expect(viewModel.trendingState == .failed(message: "Something broke"))
        #expect(viewModel.trendingState.needsLoad, "a failed load retries on the next appearance")
    }
}

@MainActor
struct NFTCarouselViewModelTests {

    @Test func usesAFallbackCollectionWhenTheSlugIsNotListed() async {
        let repository = StubNFTRepository(nftsBySlug: ["cool-cats": .success([.fixture()])])
        let viewModel = NFTCarouselViewModel(
            getNFTsUseCase: GetNFTsUseCase(repository: repository),
            getCollectionBySlugUseCase: GetCollectionBySlugUseCase(repository: repository)
        )

        await viewModel.loadIfNeeded(for: "cool-cats")

        #expect(viewModel.state.value?.collection.name == "Cool Cats")
        #expect(viewModel.state.value?.nfts.count == 1)
    }
}

@MainActor
struct SearchViewModelTests {

    /// A long debounce keeps the scheduled search out of the way of tests
    /// that call `performSearch()` directly.
    private func makeViewModel(
        search: StubSearchRepository = StubSearchRepository(),
        recent: StubNFTRepository = StubNFTRepository(),
        debounce: Duration = .seconds(60)
    ) -> SearchViewModel {
        SearchViewModel(
            searchCollectionsUseCase: SearchCollectionsUseCase(repository: search),
            searchNFTsUseCase: SearchNFTsUseCase(repository: search),
            fetchRecentCollectionsUseCase: FetchRecentCollectionsUseCase(repository: recent),
            debounce: debounce
        )
    }

    @Test func blankQueryDoesNotSearch() async {
        let viewModel = makeViewModel(search: StubSearchRepository(collections: .failure(TestError())))
        viewModel.searchText = "   "

        await viewModel.performSearch()

        #expect(viewModel.resultsState == .idle)
    }

    @Test func searchesCollections() async {
        let viewModel = makeViewModel(search: StubSearchRepository(collections: .success([.fixture(slug: "azuki")])))
        viewModel.searchText = "azuki"

        await viewModel.performSearch()

        #expect(viewModel.resultsState.value?.collections.map(\.id) == ["azuki"])
    }

    @Test func reportsSearchFailures() async {
        let viewModel = makeViewModel(search: StubSearchRepository(collections: .failure(TestError())))
        viewModel.searchText = "azuki"

        await viewModel.performSearch()

        #expect(viewModel.resultsState == .failed(message: "Search failed: Something broke"))
    }

    @Test func searchesAfterTypingPauses() async throws {
        let viewModel = makeViewModel(
            search: StubSearchRepository(collections: .success([.fixture(slug: "azuki")])),
            debounce: .milliseconds(10)
        )

        viewModel.searchText = "azuki"

        for _ in 0..<100 where viewModel.resultsState.value == nil {
            try await Task.sleep(for: .milliseconds(20))
        }
        #expect(viewModel.resultsState.value?.collections.map(\.id) == ["azuki"])
    }

    @Test func loadsRecentCollections() async {
        let viewModel = makeViewModel(recent: StubNFTRepository(collections: .success([.fixture(slug: "doodles")])))

        await viewModel.loadRecentCollectionsIfNeeded()

        #expect(viewModel.recentState.value?.map(\.id) == ["doodles"])
    }
}
