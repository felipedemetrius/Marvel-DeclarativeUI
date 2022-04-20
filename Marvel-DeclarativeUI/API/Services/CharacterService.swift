//
//  CharacterService.swift
//  Marvel-DeclarativeUI
//
//  Created by FELIPE DEMETRIUS MARTINS DA SILVA on 19/04/22.
//

import Foundation
import Alamofire

struct CharacterService: Requestable {
    var page: Int = 0
    fileprivate var parameters: Parameters

    typealias Data = [Character]

    init() {
        parameters = Authorization.credentials()
    }

    func get(_ completionHandler: @escaping (Result<[Character], NetworkingError>) -> Void) {
        getPage(page: 0, completionHandler: completionHandler)
    }
}

extension CharacterService: Pageable {
    func getPage(page: Int, completionHandler: @escaping (Result<[Character], NetworkingError>) -> Void) {

        var params = Parameters()
        params["offset"] = page
        params.merge(dictionary: self.parameters)

        let config = CharacterConfig(parameters: params)

        request(config: config, completionHandler: completionHandler)
    }
}

struct CharacterConfig: RequestConfig {
    var url: URLConvertible
    var method: HTTPMethod
    var parameters: Parameters?
    var encoding: ParameterEncoding?
    var headers: HTTPHeaders?
    var keyPath: String?

    init(parameters: Parameters) {
        self.url = API.Endpoints.makeUrl(path: .characters)
        self.method = .get
        self.encoding = URLEncoding.queryString
        self.parameters = parameters
        self.keyPath = "data.results"
    }
}
