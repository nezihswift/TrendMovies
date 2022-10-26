//
//  MovieDetailCollectionViewCell.swift
//  MovieApp
//
//  Created by Nezih on 19.10.2022.
//

import Foundation
import UIKit

class MovieDetailCollectionViewCell : UICollectionViewCell {
    private var movie : Movie?
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private var overviewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 12)
        label.textAlignment = .justified
        label.numberOfLines = 0
        return label
    }()
    
    private var voteAverageLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 12)
        return label
    }()
    
    private var releaseDateLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 12)
        return label
    }()
    
    private var languageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 12)
        return label
    }()
    
    private var backdropImage : UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView(forAutoLayout: ())
        stackView.spacing = Constants.MovieDetail.Popup.spacing
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupBackdropImage(){
        backdropImage.contentMode = .scaleToFill
        backdropImage.heightAnchor.constraint(equalToConstant: Constants.MovieDetail.Popup.backdropImageHeight).isActive = true
    }
    
    private func setupViews() {
        backgroundColor = UIColor.theme.listBackground
        setupBackdropImage()
        setupStackView()
    }
    
    private func setupStackView() {
        addSubview(stackView)
        stackView.autoPinEdge(toSuperviewEdge: .top, withInset: Constants.MovieDetail.Popup.topInset)
        stackView.autoPinEdge(toSuperviewEdge: .leading, withInset: Constants.MovieDetail.Popup.leftInset)
        stackView.autoPinEdge(toSuperviewEdge: .trailing, withInset: Constants.MovieDetail.Popup.rightInset)
        
        stackView.addArrangedSubview(backdropImage)
        stackView.addArrangedSubview(overviewLabel)
        stackView.addArrangedSubview(voteAverageLabel)
        stackView.addArrangedSubview(releaseDateLabel)
        stackView.addArrangedSubview(languageLabel)
    }
    func imdbFormatFormula(imdbValue : Double) -> String {
        (String(format: "%.1f", imdbValue))
    }
    
    
    func populate (movie: Movie){
        self.movie = movie
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
        releaseDateLabel.text = "Release Date: " + movie.releaseDate!
        if movie.voteAverage == 0.0, movie.voteAverage != nil {
            voteAverageLabel.text = "movie.voteAverage.empty".localized()
        }
        else {
            voteAverageLabel.text = "IMDB: " + imdbFormatFormula(imdbValue: movie.voteAverage!)
        }
        if movie.backdropPath != nil {
            let urlString = Constants.URL.imageBase + movie.backdropPath!
            let url = URL(string: urlString)!
            backdropImage.af.setImage(withURL: url)
            
        }
        switch movie.originalLanguage{
        case "en":
            languageLabel.text = Constants.MovieDetail.Popup.languageLabel + "language.en".localized()
        case "es":
            languageLabel.text = Constants.MovieDetail.Popup.languageLabel + "language.es".localized()
        case "zh":
            languageLabel.text = Constants.MovieDetail.Popup.languageLabel + "language.zh".localized()
        default:
            languageLabel.text = Constants.MovieDetail.Popup.languageLabel + "language.else".localized()
        }
    }
}
