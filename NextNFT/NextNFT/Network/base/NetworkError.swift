//
//  NetworkError.swift
//  NextNFT
//

import Foundation

enum NetworkError: Error, LocalizedError, Equatable {
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
