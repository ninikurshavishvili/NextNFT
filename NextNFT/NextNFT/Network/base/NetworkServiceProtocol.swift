//
//  NetworkServiceProtocol.swift
//  NextNFT
//
//  Created by Nino Kurshavishvili on 15.12.25.
//

import Foundation
import Network

protocol NetworkServiceProtocol: Sendable {
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}


