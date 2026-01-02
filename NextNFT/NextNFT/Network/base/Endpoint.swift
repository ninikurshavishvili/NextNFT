//
//  Endpoint.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 15.12.25.
//

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
}

extension Endpoint {
    var baseURL: String {
        return "https://api.opensea.io/api/v2"
    }
    
    var headers: [String: String]? {
        return [
            "X-API-KEY": "bcdf9b152b5c46308e0baa9f3711520f",
            "Accept": "application/json"
        ]
    }
}
