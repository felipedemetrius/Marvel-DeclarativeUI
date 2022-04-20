//
//  Requestable.swift
//  Marvel-DeclarativeUI
//
//  Created by FELIPE DEMETRIUS MARTINS DA SILVA on 19/04/22.
//

import Foundation
import Alamofire

protocol Requestable {
    associatedtype Data
}

protocol RequestConfig {
    var url: URLConvertible { get }
    var method: HTTPMethod { get }
    var encoding: ParameterEncoding? { get }
    var parameters: Parameters? { get }
    var headers: HTTPHeaders? { get }
    var keyPath: String? { get }
}

extension Requestable where Self.Data: Decodable {

    internal func request(config: RequestConfig, completionHandler: @escaping (Result<Data, NetworkingError>) -> Void) {
        let request: DataRequest

        if let encoding = config.encoding {
            request = AF.request(config.url, method: config.method, parameters: config.parameters, encoding: encoding, headers: config.headers)
        } else {
            request = AF.request(config.url, method: config.method, parameters: config.parameters, headers: config.headers)
        }
        request.validate()

        request.responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let object = try decoder.decode(Data.self, from: data, keyPath: config.keyPath)

                    completionHandler(Result.success(object))
                } catch let error as DecodingError {
                    completionHandler(Result
                        .failure(NetworkingError.decodingError(error)))
                } catch let error {
                    completionHandler(Result
                        .failure(NetworkingError.requestError(error)))
                }

            case .failure(let error):
                guard let dataError = response.data else {
                    completionHandler(Result
                        .failure(NetworkingError.requestError(error)))
                    return
                }

                if let apiError = String(data: dataError, encoding: .utf8) {
                    completionHandler(Result
                        .failure(NetworkingError.apiError(apiError)))
                } else {
                    completionHandler(Result
                        .failure(NetworkingError.requestError(error)))
                }
            }
        }
    }
}
