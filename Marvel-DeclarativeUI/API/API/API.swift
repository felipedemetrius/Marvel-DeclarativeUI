//
//  API.swift
//  Marvel-DeclarativeUI
//
//  Created by FELIPE DEMETRIUS MARTINS DA SILVA on 19/04/22.
//

import Foundation

struct API {
    static let limit = 20
    static let host = "https://gateway.marvel.com"

    enum Path: String {
        case characters = "/v1/public/characters"
    }
    struct Endpoints {
        public static func makeUrl(path: Path) -> String {
            return host + path.rawValue
        }
    }
}
