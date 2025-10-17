//
//  Strings+Extensions.swift
//  BestProducts
//
//  Created by Leonardo Soares on 15/10/2025.
//

import Foundation

// MARK: - SF Symbols
extension String {
    static var star : String {
        "star.fill"
    }

    static var chevronRight : String {
        "chevron.right"
    }

    static var magnifyingGlass : String {
        "magnifyingglass"
    }

    static var textFormatSize: String {
        "textformat.size"
    }
}

// MARK: - String validations

extension String {
    var isUppercaseHyphenOnly: Bool {
        self.wholeMatch(of: /^[A-Z-]+$/) == nil
    }
}
