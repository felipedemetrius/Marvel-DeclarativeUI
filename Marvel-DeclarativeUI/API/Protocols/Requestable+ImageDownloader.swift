//
//  Requestable+ImageDownloader.swift
//  Marvel-DeclarativeUI
//
//  Created by FELIPE DEMETRIUS MARTINS DA SILVA on 19/04/22.
//

import Alamofire
import UIKit

var cacheImageMemory = NSCache<NSString, UIImage>()

extension Requestable where Self.Data: UIImage {

    internal func downloadImage(url: String, completionHandler: @escaping (Result<UIImage, NetworkingError>) -> Void) {

        guard let urlValid = URL(string: url) else {
            completionHandler(Result.failure(.invalidURL(url)))
            return
        }

        if let image = cacheImageMemory.object(forKey: urlValid.absoluteString as NSString) {
            completionHandler(Result.success(image))
            return
        }

        let request = AF.request(urlValid.absoluteString, method: .get)

        request.responseData { response in
            switch response.result {
            case .success(let data):
                guard let image = UIImage(data: data) else {
                    completionHandler(Result
                        .failure(NetworkingError.emptyData))
                    return
                }
                cacheImageMemory.setObject(image, forKey: urlValid.absoluteString as NSString)
                completionHandler(Result.success(image))

            case .failure(let error):
                guard let dataError = response.data else {
                    completionHandler(Result
                        .failure(NetworkingError.emptyData))
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
