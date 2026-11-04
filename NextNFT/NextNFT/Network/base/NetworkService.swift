//
//  NetworkService.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 15.12.25.
//
import Foundation
import OSLog

class NetworkService: NetworkServiceProtocol {
    static let shared = NetworkService()
    private init() {}
    
    private let session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 60
        return URLSession(configuration: configuration)
    }()
    
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        guard var components = URLComponents(string: endpoint.baseURL + endpoint.path) else {
            throw NetworkError.invalidURL
        }
        components.queryItems = endpoint.queryItems
        
        guard let url = components.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        endpoint.headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        Logger.network.debug("Request: \(endpoint.method.rawValue) \(url.absoluteString)")
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.requestFailed
        }
        
        Logger.network.debug("Response status: \(httpResponse.statusCode) for \(url.path)")
        
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
