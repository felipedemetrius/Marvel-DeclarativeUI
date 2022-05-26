//
//  CharCellViewModel.swift
//  Marvel-DeclarativeUI
//
//  Created by FELIPE DEMETRIUS MARTINS DA SILVA on 25/05/22.
//

import DeclarativeUI
import UIKit

class CharCellViewModel: DeclarativeViewModel<Void, Error> {
    let data: Character
    
    let service = ImageDownloaderService()
    let loadingImage = Observable(false)
    let image: Observable<UIImage?> = Observable(UIImage(named: "user"))
    
    init(data: Character) {
        self.data = data
    }
    
    func getImage() {
        loadingImage.publish(true)
        
        service.downloadImage(url: data.urlImage ?? "") { [image, loadingImage] result in
            loadingImage.publish(false)
            switch result {
            case .success(let data):
                image.publish(data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
