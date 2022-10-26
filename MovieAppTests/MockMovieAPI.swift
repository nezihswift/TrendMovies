//
//  MockMovieAPI.swift
//  MovieAppTests
//
//  Created by Nezih on 16.10.2022.
//

import Foundation
@testable import MovieApp

class MockMovieAPI: MovieAPILogic {
    var loadState: MovieLoadingState = .empty
    func getMovies(completion: @escaping MovieApp.MovieListAPIResponse) {
        switch loadState {
        case .error:
            completion(.failure(.networkingError("Could not fetch movies")))
        case .loaded:
            let mock = Result(results: [Movie(id: 616820,
                                              title: "Halloween Ends",
                                              backdropPath: "/aTovumsNlDjof7YVoU5nW2RHaYn.jpg",
                                              originalLanguage: "en",
                                              overview: "Four years after the events of Halloween in 2018, Laurie has decided to liberate herself from fear and rage and embrace life. But when a young man is accused of killing a boy he was babysitting, it ignites a cascade of violence and terror that will force Laurie to finally confront the evil she can’t control, once and for all.",
                                              releaseDate: "2022-10-12",
                                              voteAverage: 7.026)])
            completion(.success(mock))
        case .empty:
            completion(.success(nil))
        }
    }
}
