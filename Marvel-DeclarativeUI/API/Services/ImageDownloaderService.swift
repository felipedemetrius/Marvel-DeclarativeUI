//
//  ImageDownloaderService.swift
//  Marvel-DeclarativeUI
//
//  Created by FELIPE DEMETRIUS MARTINS DA SILVA on 19/04/22.
//

import Foundation
import UIKit

struct ImageDownloaderService: Requestable {
    typealias Data = UIImage

    init() { }

    func downloadImage(url: String, _ completionHandler: @escaping (Result<UIImage, NetworkingError>) -> Void) {
        downloadImage(url: url, completionHandler: completionHandler)
    }
}
