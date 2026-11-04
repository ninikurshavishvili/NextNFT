//
//  NFTCarouselViewModel.swift
//  NextNFT
//
//  Created by Nini Kurshavishvili on 11.02.26.
//

import Foundation
import Observation
import OSLog

@MainActor
@Observable
final class NFTCarouselViewModel {
    struct Content: Equatable {
        let collection: NFTCollection
        let nfts: [NFT]
    }

    private(set) var state: ViewState<Content> = .idle

    private let getNFTsUseCase: GetNFTsUseCase
    private let getCollectionBySlugUseCase: GetCollectionBySlugUseCase

    init(
        getNFTsUseCase: GetNFTsUseCase,
        getCollectionBySlugUseCase: GetCollectionBySlugUseCase
    ) {
        self.getNFTsUseCase = getNFTsUseCase
        self.getCollectionBySlugUseCase = getCollectionBySlugUseCase
    }

    /// Loads on first appearance, and again after a failure or cancellation.
    func loadIfNeeded(for collectionSlug: String) async {
        guard state.needsLoad else { return }
        await loadNFTs(for: collectionSlug)
    }

    func loadNFTs(for collectionSlug: String) async {
        state = .loading

        Logger.home.debug("Loading NFTs for collection: \(collectionSlug)")

        do {
            // Load NFTs and collection details in parallel
            async let nftsTask = getNFTsUseCase.execute(for: collectionSlug)
            async let collectionTask = getCollectionBySlugUseCase.execute(for: collectionSlug)

            let (fetchedNFTs, fetchedCollection) = try await (nftsTask, collectionTask)

            Logger.home.debug("Fetched \(fetchedNFTs.count) NFTs")

            guard !fetchedNFTs.isEmpty else {
                state = .empty
                return
            }

            let collection = fetchedCollection ?? Self.fallbackCollection(for: collectionSlug)
            if fetchedCollection == nil {
                Logger.home.notice("Collection not found for slug: \(collectionSlug), using fallback")
            }

            state = .loaded(Content(collection: collection, nfts: fetchedNFTs))
        } catch where error.isCancellation {
            state = .idle
        } catch {
            state = .failed(message: error.localizedDescription)
            Logger.home.error("Error loading NFTs: \(error.localizedDescription)")
        }
    }

    /// A collection built from the slug, so the cards still show when the
    /// collection itself isn't in the fetched list.
    private static func fallbackCollection(for slug: String) -> NFTCollection {
        let readableName = slug.replacingOccurrences(of: "-", with: " ")
        return NFTCollection(
            collection: slug,
            name: readableName.capitalized,
            description: "Part of the \(readableName) collection",
            imageURL: nil,
            bannerImageURL: nil,
            owner: nil,
            category: nil,
            openseaURL: nil,
            totalSupply: nil,
            createdDate: nil
        )
    }
}
