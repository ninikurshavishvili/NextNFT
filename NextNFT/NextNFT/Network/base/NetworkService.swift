//
//  NetworkService.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 15.12.25.
//
import Foundation

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
        guard let url = URL(string: endpoint.baseURL + endpoint.path) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        endpoint.headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        if let parameters = endpoint.parameters {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        }
        
        print("🌐 Request: \(request.httpMethod ?? "GET") \(url.absoluteString)")
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.requestFailed
        }
        
        print("📡 Response Status: \(httpResponse.statusCode)")
        
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
            print("❌ Decoding error: \(error)")
            throw NetworkError.decodingFailed
        }
    }
}
