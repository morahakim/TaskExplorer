//
//  APIError.swift
//  TaskExplorer
//
//  Created by mora hakim on 11/05/26.
//

import Foundation

enum APIError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingError
    case network(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid response from server"
        case .decodingError:
            return "Failed to decode data"
        case .network(let error):
            return error.localizedDescription
        }
    }
}
