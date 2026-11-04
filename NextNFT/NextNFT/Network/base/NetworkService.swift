//
//  NetworkService.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 15.12.25.
//
import Foundation
import OSLog

final class NetworkService: NetworkServiceProtocol {
    private let session: URLSession

    init(session: URLSession = NetworkService.makeDefaultSession()) {
        self.session = session
    }

    static func makeDefaultSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 60
        return URLSession(configuration: configuration)
    }

    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        let request = try endpoint.makeURLRequest()
        let path = request.url?.path ?? endpoint.path

        Logger.network.debug("Request: \(endpoint.method.rawValue) \(request.url?.absoluteString ?? path)")

        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.requestFailed
        }

        Logger.network.debug("Response status: \(httpResponse.statusCode) for \(path)")

        switch httpResponse.statusCode {
        case 200...299:
            break
        case 401:
            throw NetworkError.unauthorized
        case 429:
            throw NetworkError.rateLimited
        default:
            throw NetworkError.invalidResponse(statusCode: httpResponse.statusCode)
        }

        do {
            let decoder = JSONDecoder()
            let decoded = try decoder.decode(T.self, from: data)
            return decoded
        } catch {
            Logger.network.error("Decoding \(String(describing: T.self)) failed: \(String(describing: error))")
            throw NetworkError.decodingFailed
        }
    }
}
