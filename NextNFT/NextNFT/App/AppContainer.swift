//
//  AppContainer.swift
//  NextNFT
//

import Foundation

/// Composition root: builds the app's dependencies once, at launch.
/// Screens get their view models from the factory methods below instead of
/// creating repositories and services themselves, so any layer can be
/// swapped for a fake in tests and previews.
@MainActor
final class AppContainer {
    let imageDownloadManager: NFTImageDownloadManagerProtocol

    private let nftRepository: NFTRepositoryProtocol
    private let searchRepository: SearchRepositoryProtocol

    init(networkService: NetworkServiceProtocol = NetworkService()) {
        let openSea = OpenSeaRemoteDataSource(networkService: networkService)
        nftRepository = NFTRepository(dataSource: openSea)
        searchRepository = SearchRepository(dataSource: openSea)
        imageDownloadManager = NFTImageDownloadManager()
    }

    // MARK: - Home

    func makeHomeViewModel() -> HomeViewModel {
        HomeViewModel(
            getTrendingCollectionsUseCase: GetTrendingCollectionsUseCase(repository: nftRepository)
        )
    }

    func makeNFTCarouselViewModel() -> NFTCarouselViewModel {
        NFTCarouselViewModel(
            getNFTsUseCase: GetNFTsUseCase(repository: nftRepository),
            getCollectionBySlugUseCase: GetCollectionBySlugUseCase(repository: nftRepository)
        )
    }

    // MARK: - Search

    func makeSearchViewModel() -> SearchViewModel {
        SearchViewModel(
            searchCollectionsUseCase: SearchCollectionsUseCase(repository: searchRepository),
            searchNFTsUseCase: SearchNFTsUseCase(repository: searchRepository),
            fetchRecentCollectionsUseCase: FetchRecentCollectionsUseCase(repository: nftRepository)
        )
    }
}
