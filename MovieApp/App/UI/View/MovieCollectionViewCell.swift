//
//  MovieCollectionViewCell.swift
//  MovieApp
//
//  Created by Nezih on 18.10.2022.
//

import Foundation
import UIKit
import AlamofireImage

class MovieCollectionViewCell : UICollectionViewCell {
    private var movie : Movie?
    
    private var posterImageView : UIImageView = {
        let image = UIImageView()
        image.widthAnchor.constraint(equalToConstant: Constants.MovieDetail.Cell.imageWidth).isActive = true
        return image
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.header
        return label
    }()
    
    private var overviewLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.text
        label.numberOfLines = 3
        return label
    }()
    
    private var languageLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.text
        return label
    }()
    
    private var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.text
        return label
    }()
    
    private var voteAverageLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.text
        return label
    }()
    
    private var wrapperView: UIView = {
        let view = UIView(forAutoLayout: ())
        view.layer.borderColor = UIColor.theme.border?.cgColor
        view.layer.borderWidth = Constants.MovieDetail.Cell.borderWidth
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init? (coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        backgroundColor = UIColor.theme.listBackground
        setupWrapperView()
        setupPosterImageView()
        setupTitleLabel()
        setupReleaseDateLabel()
        setupVoteAverageLabel()
    }
    
    private func setupWrapperView() {
        addSubview(wrapperView)
        wrapperView.autoPinEdgesToSuperviewEdges()
        wrapperView.layoutMargins = Constants.MovieDetail.Cell.wrapperViewInsets
    }
    
    private func setupPosterImageView() {
        wrapperView.addSubview(posterImageView)
        posterImageView.layer.cornerRadius = Constants.MovieDetail.Cell.cornerRadius
        posterImageView.layer.masksToBounds = true
        posterImageView.contentMode = .scaleAspectFit
        posterImageView.autoPinEdgesToSuperviewSafeArea(with: UIEdgeInsets(top: Constants.MovieDetail.Cell.topInset, left: Constants.MovieDetail.Cell.leftInset, bottom: Constants.MovieDetail.Cell.bottomInset, right: Constants.MovieDetail.Cell.rightInset), excludingEdge: .left)
        posterImageView.setContentHuggingPriority(.required, for: .horizontal)
    }
    
    private func setupTitleLabel() {
        wrapperView.addSubview(titleLabel)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = UIColor.theme.text
        titleLabel.autoPinEdge(.trailing, to: .leading, of: posterImageView)
        titleLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: Constants.MovieDetail.Cell.leftInset)
        titleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: Constants.MovieDetail.Cell.topInset)
        titleLabel.autoPinEdge(.trailing, to: .leading, of: posterImageView)
        
    }
    
    private func setupReleaseDateLabel() {
        wrapperView.addSubview(releaseDateLabel)
        releaseDateLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: Constants.MovieDetail.Cell.leftInset)
        releaseDateLabel.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: Constants.MovieDetail.Cell.topInset)
    }
    
    private func setupVoteAverageLabel() {
        wrapperView.addSubview(voteAverageLabel)
        voteAverageLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: Constants.MovieDetail.Cell.leftInset)
        voteAverageLabel.autoPinEdge(.top, to: .bottom, of: releaseDateLabel, withOffset: Constants.MovieDetail.Cell.topInset)
        voteAverageLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: Constants.MovieDetail.Cell.bottomInset)
    }
    
    func populate(_ movie: Movie) {
        self.movie = movie
        titleLabel.text = movie.title
        if movie.posterPath != nil {
            let urlString = Constants.URL.imageBase + movie.posterPath!
            let url = URL(string: urlString)!
            posterImageView.af.setImage(withURL: url)
        }
        releaseDateLabel.text = movie.releaseDate
        if movie.voteAverage == 0.0 {
            voteAverageLabel.text = "movie.voteAverage.empty".localized()
        }
        else {
            let imdbValue : Double = movie.voteAverage ?? 0.0
            voteAverageLabel.text = "IMDB: " + (String(format: "%.1f", imdbValue))
        }
        
    }
}
