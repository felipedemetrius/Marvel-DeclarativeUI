//
//  NetworkingError.swift
//  Marvel-DeclarativeUI
//
//  Created by FELIPE DEMETRIUS MARTINS DA SILVA on 19/04/22.
//

import Foundation

public enum NetworkingError: Error, CustomStringConvertible {
    case emptyData
    case responseNil
    case authentication
    case badRequest
    case outdated
    case failed
    case decodingError(DecodingError)
    case requestError(Error)
    case invalidURL(String)
    case apiError(String)

    public var localizedDescription: String {
        return description
    }

    public var description: String {
        switch self {
        case .emptyData:
            return "Empty response data"
        case .responseNil:
            return "Response is nil"
        case .requestError(let error):
            return "\(error)"
        case .invalidURL(let url):
            return "Invalid URL: \(url)"
        case .authentication:
            return "Authentication failure"
        case .badRequest:
            return "Bad request"
        case .outdated:
            return "Outdated request"
        case .failed:
            return "Network failed"
        case .decodingError(let error):
            return "Decoding error: \(error)"
        case .apiError(let error):
            return "API error: \(error)"
        }
    }
}
