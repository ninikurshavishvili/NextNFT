//
//  NetworkManager.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 25.10.25.
//

import Foundation


enum NetworkError: Error, LocalizedError {
    case invalidURL
    case requestFailed
    case invalidResponse(statusCode: Int)
    case decodingFailed
    case unauthorized
    case rateLimited

    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL."
        case .requestFailed: return "Network request failed."
        case .invalidResponse(let statusCode): return "Invalid server response. Status code: \(statusCode)"
        case .decodingFailed: return "Failed to decode response data."
        case .unauthorized: return "API key is invalid or missing."
        case .rateLimited: return "Rate limit exceeded."
        }
    }
}

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}

    // Replace with your actual OpenSea API key
    private let apiKey = "bcdf9b152b5c46308e0baa9f3711520f"
    
    // MARK: - Collections
    func getCollections(completion: @escaping (Result<[CollectionModel], Error>) -> Void) {
        // Add filtering for popular collections - use known collection slugs
        // Or use the chain parameter to get Ethereum mainnet collections (which are more likely to have images)
        
        // Option A: Fetch Ethereum collections (more likely to have images)
        guard let url = URL(string: "https://api.opensea.io/api/v2/collections?chain=ethereum&limit=10") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        // Option B: Fetch specific popular collections
        // guard let url = URL(string: "https://api.opensea.io/api/v2/collections?limit=10&chain=ethereum") else {
        
        print("Fetching collections from: \(url.absoluteString)")
        
        performRequest(url: url) { (result: Result<CollectionsResponse, Error>) in
            switch result {
            case .success(let response):
                // Filter out collections without images
                let collectionsWithImages = response.collections.filter {
                    $0.imageURL != nil && !$0.imageURL!.isEmpty
                }
                completion(.success(collectionsWithImages))
            case .failure(let error):
                print("Collections fetch error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }

    func getNFTs(for slug: String, completion: @escaping (Result<[NFTModel], Error>) -> Void) {
        guard let url = URL(string:
            "https://api.opensea.io/api/v2/collection/\(slug)/nfts?limit=10"
        ) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        print("Fetching NFTs from: \(url.absoluteString)")
        
        performRequest(url: url) { (result: Result<NFTResponse, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.nfts))
            case .failure(let error):
                print("NFTs fetch error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }

}

private extension NetworkManager {
    func performRequest<T: Decodable>(
        url: URL,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "X-API-KEY")
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        print("Making request to: \(url.absoluteString)")
        print("API Key present: \(!apiKey.isEmpty)")

        URLSession.shared.dataTask(with: request) { data, response, error in
            // Print response for debugging
            if let httpResponse = response as? HTTPURLResponse {
                print("Response status code: \(httpResponse.statusCode)")
                if let headers = httpResponse.allHeaderFields as? [String: String] {
                    print("Response headers: \(headers)")
                }
            }

            if let error = error {
                print("Network error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                print("No HTTP response received")
                completion(.failure(NetworkError.invalidResponse(statusCode: -1)))
                return
            }

            // Handle different status codes
            switch httpResponse.statusCode {
            case 200...299:
                // Success
                break
            case 401:
                completion(.failure(NetworkError.unauthorized))
                return
            case 429:
                completion(.failure(NetworkError.rateLimited))
                return
            default:
                print("Unexpected status code: \(httpResponse.statusCode)")
                completion(.failure(NetworkError.invalidResponse(statusCode: httpResponse.statusCode)))
                return
            }

            guard let data = data else {
                print("No data received")
                completion(.failure(NetworkError.requestFailed))
                return
            }

            // Print raw response for debugging
            if let responseString = String(data: data, encoding: .utf8) {
                print("Raw response: \(responseString.prefix(1000))...") // First 1000 chars
            }

            do {
                let decoder = JSONDecoder()
                // REMOVE THIS LINE - Your CodingKeys already handle snake_case conversion
                // decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let decoded = try decoder.decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                print("Decoding error: \(error)")
                print("Error details: \(error.localizedDescription)")
                
                // Print more detailed error info
                if let decodingError = error as? DecodingError {
                    switch decodingError {
                    case .keyNotFound(let key, let context):
                        print("Failed to decode key: \(key.stringValue)")
                        print("Coding path: \(context.codingPath)")
                    case .typeMismatch(let type, let context):
                        print("Type mismatch for: \(type)")
                        print("Coding path: \(context.codingPath)")
                    case .valueNotFound(let type, let context):
                        print("Value not found for: \(type)")
                        print("Coding path: \(context.codingPath)")
                    case .dataCorrupted(let context):
                        print("Data corrupted: \(context)")
                    @unknown default:
                        print("Unknown decoding error")
                    }
                }
                
                completion(.failure(NetworkError.decodingFailed))
            }

        }.resume()
    }
}





