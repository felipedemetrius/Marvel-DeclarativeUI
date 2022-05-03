//
//  ListCharsViewModel.swift
//  Marvel-DeclarativeUI
//
//  Created by FELIPE DEMETRIUS MARTINS DA SILVA on 02/05/22.
//

import DeclarativeUI

class ListCharsViewModel: DeclarativeViewModel<Void, Error> {

    var interactionEvents = Publisher<ListCharsInteractionEvents>()
    var items = Observable([Character]())
    var loadingNextPage = Observable(false)
    var service = CharacterService()

    func selectedItem(_ index: Int) {
        interactionEvents.publish(.rowSelected(index))
    }
    
    func getItems() {
        $state.publish(.loading)

        service.get { [items, $state] status in
            switch status {
            case .success(let result):
                items.value = result
                $state.publish(.ready(()))
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getNext() {
        loadingNextPage.value = true
        
        service.getNext { [loadingNextPage, items] status in
            loadingNextPage.value = false
            switch status {
            case .success(let result):
                items.value.append(contentsOf: result)
            case .failure(let error):
                print(error)
            }
        }
    }
}
