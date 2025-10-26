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
    case invalidResponse
    case decodingFailed

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .requestFailed:
            return "Network request failed."
        case .invalidResponse:
            return "Invalid server response."
        case .decodingFailed:
            return "Failed to decode response data."
        }
    }
}

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}

    private let apiKey = "bcdf9b152b5c46308e0baa9f3711520f"

    func getCollections(completion: @escaping (Result<[CollectionModel], Error>) -> Void) {
        let urlString = "https://api.opensea.io/api/v2/collections?limit=10"
        guard let url = URL(string: urlString) else { return }

        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "X-API-KEY")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else { return }

            do {
                let decoded = try JSONDecoder().decode(CollectionsResponse.self, from: data)
                completion(.success(decoded.collections))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
}




extension NetworkManager {
    func getNFTs(for collectionSlug: String, completion: @escaping (Result<[NFTModel], Error>) -> Void) {
        let urlString = "https://api.opensea.io/api/v2/collection/\(collectionSlug)/nfts?limit=10"
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        performRequest(url: url) { (result: Result<NFTResponse, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.nfts))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

private extension NetworkManager {
    func performRequest<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "X-API-KEY")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.requestFailed))
                return
            }

            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(NetworkError.decodingFailed))
            }
        }.resume()
    }
}

