//
//  ServiceError.swift
//  LeBaluchon
//
//  Created by Richardier on 16/04/2021.
//

import Foundation

enum ServiceError: Error {
    case invalidResponse
    case emptyData
    case invalidStatusCode
}

extension ServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "invalid response"
        case .emptyData:
            return "empty data"
        case .invalidStatusCode:
            return "invalid status code"
        }
    }
}
