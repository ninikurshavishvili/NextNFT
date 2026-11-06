//
//  OpenSeaAPITests.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 02.01.26.
//

import Foundation
import Testing
@testable import NextNFT

/// The requests OpenSeaEndpoint builds. Query items used to be dropped
/// silently, so these check the full URL, not just the path.
struct OpenSeaEndpointTests {

    @Test func collectionsRequestIncludesChainAndLimit() throws {
        let request = try OpenSeaEndpoint.collections(chain: "ethereum", limit: 10).makeURLRequest()

        #expect(request.httpMethod == "GET")
        #expect(request.url?.absoluteString == "https://api.opensea.io/api/v2/collections?chain=ethereum&limit=10")
    }

    @Test func nftsRequestUsesTheCollectionSlugInThePath() throws {
        let request = try OpenSeaEndpoint.nfts(collectionSlug: "pudgypenguins", limit: 5).makeURLRequest()

        #expect(request.url?.path == "/api/v2/collection/pudgypenguins/nfts")
        #expect(queryItems(of: request) == ["limit": "5"])
    }

    @Test func searchQueryIsPercentEncoded() throws {
        let request = try OpenSeaEndpoint.searchCollections(query: "bored ape", limit: 10).makeURLRequest()

        #expect(request.url?.query == "search=bored%20ape&limit=10")
    }

    @Test func requestsAskForJSONAndSendTheAPIKeyHeader() throws {
        let request = try OpenSeaEndpoint.collections().makeURLRequest()

        #expect(request.value(forHTTPHeaderField: "Accept") == "application/json")
        #expect(request.value(forHTTPHeaderField: "X-API-KEY") != nil)
    }

    private func queryItems(of request: URLRequest) -> [String: String] {
        let items = URLComponents(url: request.url!, resolvingAgainstBaseURL: false)?.queryItems ?? []
        return Dictionary(uniqueKeysWithValues: items.map { ($0.name, $0.value ?? "") })
    }
}
