//
//  MovieDataAPI.swift
//  MovieApp
//
//  Created by Nezih on 15.10.2022.
//

import Foundation
import Alamofire

typealias MovieListAPIResponse = ((Swift.Result<Result?, DataError>) -> Void)

protocol MovieAPILogic {
    func getMovies(completion : @escaping MovieListAPIResponse)
}

class MovieAPI : MovieAPILogic {
    
    func getMovies(completion : @escaping MovieListAPIResponse) {
        AF.request(Constants.URL.trendingMovies)
            .validate()
            .responseDecodable(of: Result.self) { response in
                switch response.result {
                case .failure(let error):
                    completion(.failure(.networkingError(error.localizedDescription)))
                case .success(let movies):
                    completion(.success(movies))
                }
            }
    }
}
