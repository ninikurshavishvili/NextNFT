//
//  Endpoint.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 15.12.25.
//

import Foundation

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var queryItems: [URLQueryItem]? { get }
}

extension Endpoint {
    var baseURL: String {
        return "https://api.opensea.io/api/v2"
    }
    
    var headers: [String: String]? {
        return [
            "X-API-KEY": APIConfiguration.openSeaAPIKey,
            "Accept": "application/json"
        ]
    }
    
    var queryItems: [URLQueryItem]? {
        return nil
    }

    /// The full request: base URL, path, query items, method and headers.
    func makeURLRequest() throws -> URLRequest {
        guard var components = URLComponents(string: baseURL + path) else {
            throw NetworkError.invalidURL
        }
        components.queryItems = queryItems

        guard let url = components.url else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        return request
    }
}
