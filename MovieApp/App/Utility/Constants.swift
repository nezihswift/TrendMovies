//
//  Constanta.swift
//  MovieApp
//
//  Created by Nezih on 26.10.2022.
//

import Foundation
import UIKit

class Constants {
    struct Font {
        static let header = UIFont(name: "HelveticaNeue-Bold", size: 16)
        static let text = UIFont(name: "HelveticaNeue-Bold", size: 12)
    }
    
    
    struct URL {
        // Let my api key alone >:(
        static let trendingMovies : String = "https://api.themoviedb.org/3/trending/movie/day?api_key=cfe7f8752acca72aa2075de691b9482c"
        static let imageBase : String = "https://image.tmdb.org/t/p/original"
    }
    
    struct MovieCollection {
        static let cellIdentifier : String = "movieCell"
        static let headerIdentifier : String = "movieHeaderCell"
        static let cellHeight : CGFloat = 200
        static let sectionHeaderHeight : CGFloat = 40
        static let undefinedText : String = "Undefined"
        static let navigationBarBorderWidth : CGFloat = 0.5
    }
    
    struct MovieState {
        static let stackViewSpacing: CGFloat = 30
        static let stackViewInsets = UIEdgeInsets(top: 200, left: 100, bottom: 200, right: 100)
        static let headerLabelWidth: CGFloat = 200
        static let iconImageSize = CGSize(width: 200, height: 200)
    }
    
    struct MovieDetail {
        static let movieDetailCellIdentifier : String = "movieDetailsCell"
        static let detailsCellHeight : CGFloat = 600
        static let sectionHeaderIdentifier : String = "sectionHeader"
        static let sectionHeight : CGFloat = 50
        
        struct Cell {
            static let leftInset: CGFloat = 10
            static let topInset: CGFloat = 10
            static let rightInset: CGFloat = 10
            static let bottomInset: CGFloat = 10
            static let borderWidth: CGFloat = 0.5
            static let cornerRadius: CGFloat = 10.0
            static let wrapperViewInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
            static let imageWidth: CGFloat = 115.0
        }
        
        struct Popup {
            static let languageLabel: String = "Language: "
            static let leftInset: CGFloat = 10
            static let topInset: CGFloat = 10
            static let rightInset: CGFloat = 10
            static let spacing: CGFloat = 5.0
            static let backdropImageHeight : CGFloat = 250.0
        }
    }
}
