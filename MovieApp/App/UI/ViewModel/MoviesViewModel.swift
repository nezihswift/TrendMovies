//
//  MoviesViewModel.swift
//  MovieApp
//
//  Created by Nezih on 16.10.2022.
//

import Foundation
import Combine


class MoviesViewModel {
    @Published private (set) var movies: Result? = Result.init(results: [])
    @Published private (set) var error: DataError? = nil
    private(set) var movieSectionList: [MovieSection]?
    
    private let apiService : MovieAPILogic
    
    
    init(apiService : MovieAPILogic = MovieAPI()) {
        self.apiService = apiService
    }
    
    func getMovies(){
        apiService.getMovies { [weak self] result in
            switch result {
            case .success(let movies):
                self?.movies = movies
                if movies?.results.isEmpty == false {
                    self?.prepareMovieSections()
                }
            case .failure(let error):
                self?.error = error
            }
        }
    }

    private func prepareMovieSections() {
        var listOfSections = [MovieSection]()
        var movieDictionary = [String: MovieSection]()
        for movie in movies!.results {
            if let language = movie.originalLanguage {
                if movieDictionary[language] != nil {
                    movieDictionary[language]?.movies.append(movie)
                }
                else {
                    var newSection = MovieSection(language: language, movies: [])
                    newSection.movies.append(movie)
                    movieDictionary[language] = newSection
                }
            }
        }
        listOfSections = Array(movieDictionary.values)
        listOfSections.sort {
            return $0.language < $1.language
        }
        movieSectionList = listOfSections
    }
}
