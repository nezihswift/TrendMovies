//
//  MovieListStateView.swift
//  MovieApp
//
//  Created by Nezih on 19.10.2022.
//

import Foundation
import UIKit
import PureLayout

enum MovieLoadState {
    case loaded
    case empty
    case error
}

class MovieListStateView: UIView {
    
    var headerLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.header
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    var iconImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    var messageLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.text
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("fatal_error.MovieListStateView".localized())
    }
    
    private func setupViews() {
        let stackView = UIStackView(forAutoLayout: ())
        stackView.axis = .vertical
        stackView.spacing = Constants.MovieState.stackViewSpacing
        addSubview(stackView)
        
        stackView.autoPinEdgesToSuperviewEdges(with: Constants.MovieState.stackViewInsets)
        stackView.addArrangedSubview(headerLabel)
        stackView.addArrangedSubview(messageLabel)
        
        headerLabel.autoSetDimension(.width, toSize: Constants.MovieState.headerLabelWidth)
        messageLabel.autoSetDimension(.width, toSize: Constants.MovieState.headerLabelWidth)
        stackView.addArrangedSubview(iconImageView)
        iconImageView.autoSetDimensions(to: Constants.MovieState.iconImageSize)
    }
    
    func update(for state : MovieLoadState){
        switch state {
        case .loaded:
            /// Loaded state will not be used
            break
        case .empty:
            headerLabel.text = "movie.list.empty.title".localized()
            messageLabel.text = "movie.list.empty.description".localized()
            iconImageView.image = UIImage(named: "error")
        case .error:
            headerLabel.text = "movie.list.error.title".localized()
            messageLabel.text = "movie.list.error.description".localized()
            iconImageView.image = UIImage(named: "customer")
        }
    }
}
