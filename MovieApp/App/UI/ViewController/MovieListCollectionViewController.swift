//
//  ViewController.swift
//  MovieApp
//
//  Created by Nezih on 15.10.2022.
//

import UIKit
import Combine
import PureLayout
import MBProgressHUD

class MovieListCollectionViewController: UIViewController {

    private let moviesViewModel : MoviesViewModel = MoviesViewModel()
    private var cancellables = Set<AnyCancellable>()
    private var collectionView : UICollectionView?
    private var loadingHUD : MBProgressHUD?
    private let refreshControl = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setupCollectionView()
        setupBinders()
        setupLoadingHUD()
        retrieveMovieData()
        setupRefreshControl()
    }
    
    private func setupNavigationController() {
        title = "movies.title".localized()
        if let navigationObject = self.navigationController {
            navigationObject.view.backgroundColor = UIColor.theme.background
            navigationObject.navigationBar.barTintColor = UIColor.theme.background
            navigationObject.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.theme.titleText ?? .white]
        }
        
    }
    
    private func setupRefreshControl(){
        refreshControl.attributedTitle = NSAttributedString(string: "pull.to.refresh.title".localized())
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        collectionView?.addSubview(refreshControl)
    }
    
    @objc private func refresh(_ sender: AnyObject) {
        retrieveMovieData()
        refreshControl.endRefreshing()
    }
    
    private func retrieveMovieData(){
        removeStateView()
        loadingHUD?.show(animated: true)
        moviesViewModel.getMovies()
    }
    
    private func setupLoadingHUD(){
        guard let collectionView = collectionView else {
            return
        }
        
        loadingHUD = MBProgressHUD.showAdded(to: collectionView, animated: true)
        loadingHUD?.label.text = "loading.hud.title".localized()
        loadingHUD?.isUserInteractionEnabled = false
        loadingHUD?.detailsLabel.text = "loading.hud.subtitle".localized()
    }

    private func setupCollectionView() {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = CGSize(width: view.frame.size.width, height: Constants.MovieCollection.cellHeight)
        collectionViewLayout.sectionHeadersPinToVisibleBounds = true
        collectionViewLayout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: collectionViewLayout)
        
        
        guard let collectionView = collectionView else {
            return
        }
        
        view.addSubview(collectionView)
        collectionView.autoPinEdgesToSuperviewEdges()

        collectionView.backgroundColor = UIColor.theme.background
        collectionView.alwaysBounceVertical = true
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: Constants.MovieCollection.cellIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupBinders() {
        moviesViewModel.$movies
            .receive(on: RunLoop.main)
            .sink { [weak self] movies in
                guard let movies = movies else {
                    return
                }
                
                
                if !movies.results.isEmpty {
                    self?.loadingHUD?.hide(animated: true)
                    self?.collectionView?.reloadData()
                    self?.removeStateView()
                }
                else {
                    self?.showEmptyState()
                }
            }
            .store(in: &cancellables)
        
        moviesViewModel.$error
            .receive(on: RunLoop.main)
            .sink{ [weak self] error in
                guard let self = self else {
                    return
                }
                
                if let error = error {
                    self.loadingHUD?.hide(animated: true)
                    switch error {
                    case .networkingError(let errormessage):
                        self.showErrorState(ErrorMessage: errormessage)
                    }
                }
            }
            .store(in: &cancellables)
        
    }

}

extension MovieListCollectionViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesViewModel.movieSectionList?[section].movies.count ?? 0
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.MovieCollection.cellIdentifier, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        if let movieSection = moviesViewModel.movieSectionList?[indexPath.section] {
            let movie = movieSection.movies[indexPath.item]
            cell.populate(movie)
        }
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension MovieListCollectionViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movie = moviesViewModel.movieSectionList?[indexPath.section].movies[indexPath.item]{
            let movieDetailViewController = MovieDetailViewController()
            movieDetailViewController.viewModel = MovieDetailsViewModel(movie: movie)
            present(movieDetailViewController, animated: true)
        }
    }
}

extension MovieListCollectionViewController {
    func showErrorState(ErrorMessage errorMessage: String) {
        let errorStateView = MovieListStateView(forAutoLayout: ())
        errorStateView.update(for: .error)
        collectionView?.backgroundView = errorStateView
    }
    func removeStateView() {
        collectionView?.backgroundView = nil
    }
    func showEmptyState() {
        let emptyStateView = MovieListStateView(forAutoLayout: ())
        emptyStateView.update(for: .empty)
        collectionView?.backgroundView = emptyStateView
    }
}
