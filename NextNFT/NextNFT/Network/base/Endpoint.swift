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
}
