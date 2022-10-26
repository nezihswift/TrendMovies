//
//  Movie.swift
//  MovieApp
//
//  Created by Nezih on 15.10.2022.
//

import Foundation

struct Movie : Decodable {
    let id : Int
    let title : String?
    let backdropPath : String?
    let originalLanguage : String?
    let overview : String?
    let posterPath : String?
    let releaseDate : String?
    let voteAverage : Double?
    
    enum CodingKeys : String, CodingKey {
        case id
        case title
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
}
