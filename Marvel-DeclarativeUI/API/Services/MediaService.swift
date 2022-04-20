//
//  MediaService.swift
//  Marvel-DeclarativeUI
//
//  Created by FELIPE DEMETRIUS MARTINS DA SILVA on 19/04/22.
//

import Foundation
import Alamofire

struct MediaService: Requestable {
    var page: Int = 0
    typealias Data = [Media]
    fileprivate var parameters: Parameters
    fileprivate var url: String!

    init(url: String) {
        self.url = url
        parameters = Authorization.credentials()
    }

    func get(_ completionHandler: @escaping (Result<[Media], NetworkingError>) -> Void) {
        getPage(page: 0, completionHandler: completionHandler)
    }
}

extension MediaService: Pageable {
    func getPage(page: Int, completionHandler: @escaping (Result<[Media], NetworkingError>) -> Void) {

        var params = Parameters()
        params["offset"] = page
        params.merge(dictionary: self.parameters)

        let config = MediaConfig(parameters: params, url: self.url)

        request(config: config, completionHandler: completionHandler)
    }
}

struct MediaConfig: RequestConfig {
    var url: URLConvertible
    var method: HTTPMethod
    var parameters: Parameters?
    var encoding: ParameterEncoding?
    var headers: HTTPHeaders?
    var keyPath: String?

    init(parameters: Parameters,
         url: URLConvertible) {
        self.url = url
        self.method = .get
        self.encoding = URLEncoding.queryString
        self.parameters = parameters
        self.keyPath = "data.results"
    }
}
