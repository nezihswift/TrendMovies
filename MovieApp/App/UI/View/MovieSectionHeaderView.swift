//
//  MovieSectionHeaderView.swift
//  MovieApp
//
//  Created by Nezih on 19.10.2022.
//

import Foundation
import UIKit

class MovieSectionHeaderView : UICollectionReusableView {
    var headerLabel : UILabel = {
        let label = UILabel()
        label.font = Constants.Font.header
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented. MovieSectionHeaderView")
    }
    
    private func setupViews() {
        addSubview(headerLabel)
        headerLabel.autoPinEdgesToSuperviewEdges()
        backgroundColor = UIColor.theme.detailTitleBackground
        
        headerLabel.textColor = UIColor.theme.titleText
    }
}
