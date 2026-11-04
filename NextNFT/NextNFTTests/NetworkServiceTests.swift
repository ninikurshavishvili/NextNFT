//
//  NetworkServiceTests.swift
//  NextNFTTests
//

import Foundation
import Testing
@testable import NextNFT

@Suite(.serialized)
struct NetworkServiceTests {
    private let service = NetworkService(session: StubURLProtocol.makeSession())
    private let endpoint = OpenSeaEndpoint.collections(chain: "ethereum", limit: 10)

    @Test func decodesASuccessfulResponse() async throws {
        StubURLProtocol.respond(statusCode: 200, body: """
        {"collections": [{"collection": "azuki", "name": "Azuki", "image_url": "https://example.com/azuki.png"}]}
        """)

        let response: CollectionsResponseDTO = try await service.request(endpoint)

        #expect(response.collections.map(\.collection) == ["azuki"])
        #expect(response.collections.first?.imageUrl == "https://example.com/azuki.png")
    }

    @Test func sendsTheEndpointsQueryItems() async throws {
        let requestedURL = LockedBox<URL?>(nil)
        StubURLProtocol.handler = { request in
            requestedURL.value = request.url
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, Data(#"{"collections": []}"#.utf8))
        }

        let _: CollectionsResponseDTO = try await service.request(endpoint)

        #expect(requestedURL.value?.query == "chain=ethereum&limit=10")
    }

    @Test(arguments: [
        (401, NetworkError.unauthorized),
        (429, NetworkError.rateLimited),
        (500, NetworkError.invalidResponse(statusCode: 500)),
    ])
    func mapsErrorStatusCodes(statusCode: Int, expected: NetworkError) async {
        StubURLProtocol.respond(statusCode: statusCode, body: "{}")

        await #expect(throws: expected) {
            let _: CollectionsResponseDTO = try await service.request(endpoint)
        }
    }

    @Test func reportsMalformedJSONAsDecodingFailed() async {
        StubURLProtocol.respond(statusCode: 200, body: #"{"unexpected": true}"#)

        await #expect(throws: NetworkError.decodingFailed) {
            let _: CollectionsResponseDTO = try await service.request(endpoint)
        }
    }
}

/// Lets the URLProtocol handler (called on URLSession's queue) hand a value back to the test.
final class LockedBox<Value>: @unchecked Sendable {
    private let lock = NSLock()
    private var stored: Value

    init(_ value: Value) { stored = value }

    var value: Value {
        get { lock.withLock { stored } }
        set { lock.withLock { stored = newValue } }
    }
}
