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
    
    lazy var activityIndicatorNext = ActivityIndicator(style: .gray, startAnimating: false)
        .color(.black)
    
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
        activityIndicatorNext.animate(viewModel.loadingNextPage)
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
            ActivityIndicator()
                .color(.black)
            Spacer(.medium)
            Label(text: "Loading ...", style: .boldSystemFont())
                .alignment(.center)
            Spacer(.flexible)
        }
    }

    private func stateReady() -> StackView {
        return StackView(.vertical) {
            listView
                .refresh { [viewModel] in
                    viewModel.getItems()
                }
                .didScroll { [viewModel, listView] scrollView in
                    let maximumOffset = scrollView.contentSize.height - listView.rootView.frame.size.height

                    if viewModel.items.value.isEmpty {
                        return
                    }

                    if maximumOffset - scrollView.contentOffset.y <= 0 {
                        if !viewModel.loadingNextPage.value {
                            viewModel.getNext()
                        }
                    }
                }
            activityIndicatorNext
            Spacer(.small)
        }
    }

}
