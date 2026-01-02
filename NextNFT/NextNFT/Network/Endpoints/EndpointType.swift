//
//  EndpointType.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 15.12.25.
//

enum EndpointType {
    case getCollections(chain: String, limit: Int)
    case getNFTs(collectionSlug: String, limit: Int)
    
    var path: String {
        switch self {
        case .getCollections:
            return "/collections"
        case .getNFTs(let slug, _):
            return "/collection/\(slug)/nfts"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getCollections(let chain, let limit):
            return ["chain": chain, "limit": limit]
        case .getNFTs(_, let limit):
            return ["limit": limit]
        }
    }
}
