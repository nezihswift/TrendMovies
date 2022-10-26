//
//  StringsHelper.swift
//  MovieApp
//
//  Created by Nezih on 18.10.2022.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localized(params: CVarArg...) -> String {
        return String(format: localized(), arguments: params)
    }
}
