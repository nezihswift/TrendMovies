//
//  Result.swift
//  MovieApp
//
//  Created by Nezih on 15.10.2022.
//  

import Foundation

struct Result : Decodable{
    let results : [Movie]
    
    enum CodingKeys : String, CodingKey {
        case results
    }
}
