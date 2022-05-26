//
//  CharCell.swift
//  Marvel-DeclarativeUI
//
//  Created by FELIPE DEMETRIUS MARTINS DA SILVA on 25/05/22.
//

import DeclarativeUI
import UIKit

public class CharCell: DeclarativeComponent {
    
    private lazy var title = Label(
        text: viewModel.data.name ?? "",
        style: .boldSystemFont(color: .black, ofSize: 24)
    )

    lazy var image = Image(viewModel.image)
        .width(.extraLarge5)
        .height(.extraLarge5)
        .cornerRadius(.extraLarge)
        .border(.black, width: .extraSmall4)
        
    private lazy var activityIndicator = ActivityIndicator(style: .gray)
        .animate(viewModel.loadingImage)
    
    public lazy var view = StackView(.horizontal) {
        image
            .subview(activityIndicator) { layout in
                layout.center(in: image.rootView)
            }
        title
    }.distribution(.fill)
    .spacing(.small)
    .padding(.uniform(.small))

    private let viewModel: CharCellViewModel
    
    init(viewModel: CharCellViewModel) {
        self.viewModel = viewModel
        viewModel.getImage()
    }
}
