//
//  NetworkManager.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 25.10.25.
//

import Foundation

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
