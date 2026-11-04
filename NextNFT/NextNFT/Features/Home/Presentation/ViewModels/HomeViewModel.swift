//
//  HomeViewModel.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 03.01.26.
//

import Foundation
import Observation

@MainActor
@Observable
final class HomeViewModel {
    private(set) var trendingState: ViewState<[TrendingCollection]> = .idle

    private let getTrendingCollectionsUseCase: GetTrendingCollectionsUseCase

    init(getTrendingCollectionsUseCase: GetTrendingCollectionsUseCase) {
        self.getTrendingCollectionsUseCase = getTrendingCollectionsUseCase
    }

    /// Loads on first appearance, and again after a failure or cancellation.
    func loadIfNeeded() async {
        guard trendingState.needsLoad else { return }
        await load()
    }

    func load() async {
        trendingState = .loading

        do {
            let collections = try await getTrendingCollectionsUseCase.execute()
            trendingState = collections.isEmpty ? .empty : .loaded(collections)
        } catch where error.isCancellation {
            trendingState = .idle
        } catch {
            trendingState = .failed(message: error.localizedDescription)
        }
    }
}
