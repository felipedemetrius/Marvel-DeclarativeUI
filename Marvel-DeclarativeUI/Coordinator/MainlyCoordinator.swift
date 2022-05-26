//
//  MainlyCoordinator.swift
//  Marvel-DeclarativeUI
//
//  Created by FELIPE DEMETRIUS MARTINS DA SILVA on 02/05/22.
//

import Foundation
import DeclarativeUI
import UIKit

class MainlyCoordinator: DeclarativeCoordinator {
    init() {
        super.init(backIcon: Image(Images.back), closeIcon: Image(Images.close))
    }
    
    func start() {
        let viewModel = ListCharsViewModel()
        
        observe(viewModel.interactionEvents) { `self`, event in
            switch event {
            case .rowSelected(let index):
                print(viewModel.items.value[index])
            }
        }
        
        let viewController = ListCharsViewController(viewModel: viewModel)
            .navigationTitle("Characters")
        
        navigator.push(viewController)
    }
}
