//
//  ListCharsViewController.swift
//  Marvel-DeclarativeUI
//
//  Created by FELIPE DEMETRIUS MARTINS DA SILVA on 02/05/22.
//

import DeclarativeUI

public class ListCharsViewController: DeclarativeViewController {
    
    public lazy var viewController = ViewController(view: view)
   
    private let viewModel: ListCharsViewModel

    lazy var listView = ListView(viewModel.items) { [row, viewModel] dataSource in
        for (index, text) in dataSource.enumerated() {
            row(text, index) { index in
                viewModel.selectedItem(index)
            }
        }
    }.separatorStyle(.none)
    
    private lazy var view = StateView()
        .onLoading { [stateLoading] in
            stateLoading()
        }
        .onReady { [stateReady]  in
            stateReady()
        }
        .observe(viewModel.$state)

    init(viewModel: ListCharsViewModel) {
        self.viewModel = viewModel
        viewModel.getItems()
    }
    
    private func row(char: Character, index: Int, action: @escaping (Int) -> Void) -> Row {
        StackView(.horizontal) {
            Label(text: char.name ?? "", style: .boldSystemFont())
        }
        .asRow()
        .onTap {
            action(index)
        }
    }
    
    private func stateLoading() -> StackView {
        return StackView(.vertical) {
            Spacer(.extraLarge4)
            Label(text: "...", style: .boldSystemFont())
            Spacer(.flexible)
        }
    }

    private func stateReady() -> StackView {
        return StackView(.vertical) {
            listView
            Label(text: "...", style: .boldSystemFont())
                .hidden(when: viewModel.loadingNextPage)
            Spacer(.small)
        }
    }

}
