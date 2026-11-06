//
//  HomeUseCaseTests.swift
//  NextNFTTests
//

import Testing
@testable import NextNFT

struct GetNFTsUseCaseTests {

    @Test func keepsOnlyNFTsACardCanShow() async throws {
        let repository = StubNFTRepository(nftsBySlug: ["azuki": .success([
            .fixture(identifier: "ok"),
            .fixture(identifier: "display-image-only", imageURL: nil, displayImageURL: "https://example.com/d.png"),
            .fixture(identifier: "no-image", imageURL: nil),
            .fixture(identifier: "empty-image", imageURL: ""),
            .fixture(identifier: "no-name", name: nil),
            .fixture(identifier: "disabled", isDisabled: true),
        ])])

        let nfts = try await GetNFTsUseCase(repository: repository).execute(for: "azuki")

        #expect(nfts.map(\.identifier) == ["ok", "display-image-only"])
    }
}

struct GetTrendingCollectionsUseCaseTests {

    @Test func returnsCollectionsWithTheirDisplayableNFTs() async throws {
        let repository = StubNFTRepository(
            collections: .success([.fixture(slug: "azuki", name: "Azuki")]),
            nftsBySlug: ["azuki": .success([.fixture(identifier: "1"), .fixture(identifier: "2", name: nil)])]
        )

        let trending = try await GetTrendingCollectionsUseCase(repository: repository).execute()

        #expect(trending.map(\.collection.collection) == ["azuki"])
        #expect(trending.first?.nfts.map(\.identifier) == ["1"])
    }

    @Test func dropsCollectionsWithoutAnImageOrNFTs() async throws {
        let repository = StubNFTRepository(
            collections: .success([
                .fixture(slug: "no-image", imageURL: nil),
                .fixture(slug: "no-nfts"),
                .fixture(slug: "nfts-fail"),
                .fixture(slug: "good"),
            ]),
            nftsBySlug: [
                "no-image": .success([.fixture()]),
                "nfts-fail": .failure(TestError()),
                "good": .success([.fixture()]),
            ]
        )

        let trending = try await GetTrendingCollectionsUseCase(repository: repository).execute()

        #expect(trending.map(\.collection.collection) == ["good"])
    }

    @Test func ranksWellKnownCollectionsFirst() async throws {
        let repository = StubNFTRepository(
            collections: .success([
                .fixture(slug: "plain", name: "Plain Collection"),
                .fixture(slug: "punks", name: "CryptoPunks"),
            ]),
            nftsBySlug: ["plain": .success([.fixture()]), "punks": .success([.fixture()])]
        )

        let trending = try await GetTrendingCollectionsUseCase(repository: repository).execute()

        #expect(trending.map(\.collection.collection) == ["punks", "plain"])
    }

    @Test func returnsAtMostTwentyCollections() async throws {
        let slugs = (1...25).map { "collection-\($0)" }
        let repository = StubNFTRepository(
            collections: .success(slugs.map { .fixture(slug: $0) }),
            nftsBySlug: Dictionary(uniqueKeysWithValues: slugs.map { ($0, .success([NFT.fixture()])) })
        )

        let trending = try await GetTrendingCollectionsUseCase(repository: repository).execute()

        #expect(trending.count == 20)
    }

    @Test func throwsWhenCollectionsFailToLoad() async {
        let repository = StubNFTRepository(collections: .failure(TestError()))

        await #expect(throws: TestError.self) {
            try await GetTrendingCollectionsUseCase(repository: repository).execute()
        }
    }
}

struct GetCollectionBySlugUseCaseTests {
    private let repository = StubNFTRepository(collections: .success([
        .fixture(slug: "boredapeyachtclub", name: "Bored Ape Yacht Club"),
        .fixture(slug: "Azuki", name: "Azuki"),
    ]))

    @Test func findsAnExactMatch() async throws {
        let collection = try await GetCollectionBySlugUseCase(repository: repository).execute(for: "boredapeyachtclub")
        #expect(collection?.name == "Bored Ape Yacht Club")
    }

    @Test func matchesIgnoringCase() async throws {
        let collection = try await GetCollectionBySlugUseCase(repository: repository).execute(for: "azuki")
        #expect(collection?.name == "Azuki")
    }

    @Test func returnsNilWhenNothingMatches() async throws {
        let collection = try await GetCollectionBySlugUseCase(repository: repository).execute(for: "cryptopunks")
        #expect(collection == nil)
    }
}
