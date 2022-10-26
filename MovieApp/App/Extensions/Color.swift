//
//  Color.swift
//  MovieApp
//
//  Created by Nezih on 26.10.2022.
//

import Foundation
import UIKit

extension UIColor {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let accent = UIColor(named: "AccentColor")
    let background = UIColor(named: "BackgroundColor")
    let text = UIColor(named: "TextColor")
    let titleText = UIColor(named: "TitleTextColor")
    let listBackground = UIColor(named: "ListBackgroundColor")
    let border = UIColor(named: "BorderColor")
    let detailTitleBackground = UIColor(named: "DetailTitleBackgroundColor")
}
