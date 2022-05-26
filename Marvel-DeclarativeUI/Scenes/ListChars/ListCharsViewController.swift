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
        for (index, data) in dataSource.enumerated() {
            row(data, index) { index in
                viewModel.selectedItem(index)
            }
        }
    }.separatorStyle(.singleLine)
        
    private lazy var view = StateView()
        .onLoading { [stateLoading] in
            stateLoading()
        }
        .onReady { [stateReady]  in
            stateReady()
        }
        .onError{ [stateError] error in
            stateError(error)
        }
        .observe(viewModel.$state)

    init(viewModel: ListCharsViewModel) {
        self.viewModel = viewModel
        viewModel.getItems()
    }
    
    private func row(char: Character, index: Int, action: @escaping (Int) -> Void) -> Row {
        let viewModel = CharCellViewModel(data: char)
        let cell = CharCell(viewModel: viewModel)
        return cell
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

                    if maximumOffset - scrollView.contentOffset.y <= 0 {
                        if !viewModel.loadingNextPage.value {
                            viewModel.getNext()
                        }
                    }
                }
            ActivityIndicator(style: .gray, startAnimating: false)
                .color(.black)
                .animate(viewModel.loadingNextPage)
            Spacer(.small)
        }
    }

    private func stateError(error: Error) -> StackView {
        return StackView(.vertical) {
            Spacer(.extraLarge4)
            Label(text: error.localizedDescription, style: .boldSystemFont())
                .alignment(.center)
                .padding(.horizontal(.medium))
            Spacer(.medium)
            StackView() {
                ContainerView {
                    Label(text: "Retry", style: .boldSystemFont(color: .white, ofSize: 20))
                        .alignment(.center)
                }.backgroundColor(.black)
                .width(.extraLarge7)
                .height(.large)
                .rounded()
                .onTap { [viewModel] in
                    viewModel.getItems()
                }
            }.padding(.horizontal(.medium))
            Spacer(.flexible)
        }
    }

}
