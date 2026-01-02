//
//  OpenSeaEndpoint.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 15.12.25.
//

import Foundation

// Network/Endpoints/OpenSeaEndpoint.swift
enum OpenSeaEndpoint {
    case collections(chain: String = "ethereum", limit: Int = 10)
    case nfts(collectionSlug: String, limit: Int = 10)
}

extension OpenSeaEndpoint: Endpoint {
    var parameters: [String: Any]? {
        return nil  // Using queryItems for GET requests
    }
    
    var path: String {
        switch self {
        case .collections:
            return "/api/v2/collections"
        case .nfts(let slug, _):
            return "/api/v2/collection/\(slug)/nfts"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .collections(let chain, let limit):
            return [
                URLQueryItem(name: "chain", value: chain),
                URLQueryItem(name: "limit", value: "\(limit)")
            ]
        case .nfts(_, let limit):
            return [
                URLQueryItem(name: "limit", value: "\(limit)")
            ]
        }
    }
    
    // Use your API base URL
    var baseURL: String {
        return "https://api.opensea.io"
    }
}
