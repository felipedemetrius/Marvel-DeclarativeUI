//
//  Pageable.swift
//  Marvel-DeclarativeUI
//
//  Created by FELIPE DEMETRIUS MARTINS DA SILVA on 19/04/22.
//

import Foundation
import Alamofire

protocol Pageable: Requestable {
    var page: Int {get set}

    mutating func getNext(_ completionHandler: @escaping (Result<Self.Data, NetworkingError>) -> Void)
    func getPage(page: Int, completionHandler: @escaping (Result<Self.Data, NetworkingError>) -> Void)
}

extension Pageable {
    mutating public func getNext(_ completionHandler: @escaping (Result<Self.Data, NetworkingError>) -> Void) {
        page += API.limit
        getPage(page: page, completionHandler: completionHandler)
    }
}
