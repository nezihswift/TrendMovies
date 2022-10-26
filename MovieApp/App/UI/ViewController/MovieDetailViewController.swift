//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by Nezih on 19.10.2022.
//

import Foundation
import UIKit
import PureLayout

class MovieDetailViewController : UIViewController {
    private var sectionList: [String] = ["school.details.section".localized()]
    private var collectionView : UICollectionView?
    
    var viewModel : MovieDetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = viewModel?.movie.title ?? "Undefined"
        view.backgroundColor = UIColor.theme.accent
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = CGSize(width: view.frame.size.width, height: Constants.MovieDetail.detailsCellHeight)
        collectionViewLayout.headerReferenceSize = CGSize(width: view.frame.size.width, height: Constants.MovieDetail.sectionHeight)
        collectionViewLayout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: collectionViewLayout)
        
        guard let collectionView = collectionView else {
            return
        }
        
        view.addSubview(collectionView)
        collectionView.autoPinEdgesToSuperviewEdges()
        collectionView.backgroundColor = UIColor.theme.listBackground
        collectionView.alwaysBounceVertical = true
        
        collectionView.register(MovieDetailCollectionViewCell.self, forCellWithReuseIdentifier: Constants.MovieDetail.movieDetailCellIdentifier)
        collectionView.register(MovieSectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constants.MovieDetail.sectionHeaderIdentifier)
        collectionView.dataSource = self
    }
    
}

extension MovieDetailViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionList.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section{
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.MovieDetail.movieDetailCellIdentifier, for: indexPath)
            guard let movieDetailCell = cell as? MovieDetailCollectionViewCell, let movie = viewModel?.movie else {
                return cell
            }
            movieDetailCell.populate(movie: movie)
            return movieDetailCell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader, let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constants.MovieDetail.sectionHeaderIdentifier, for: indexPath) as? MovieSectionHeaderView {
            sectionHeader.headerLabel.text = viewModel?.movie.title
            return sectionHeader
        }
        return UICollectionReusableView()
    }
}

extension MovieDetailViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: Constants.MovieDetail.detailsCellHeight)
    }
}
