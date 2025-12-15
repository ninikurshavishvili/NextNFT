//
//  OpenSeaEndpoint.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 15.12.25.
//

struct OpenSeaEndpoint: Endpoint {
    let type: EndpointType
    
    var path: String {
        return type.path
    }
    
    var method: HTTPMethod {
        return type.method
    }
    
    var parameters: [String: Any]? {
        return type.parameters
    }
}
