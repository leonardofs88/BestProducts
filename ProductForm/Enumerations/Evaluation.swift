//
//  Evaluation.swift
//  BestProducts
//
//  Created by Leonardo Soares on 17/10/2025.
//

import Foundation

enum Evaluation: String, MenuPickItem {
    case bad
    case regular
    case good
    case veryGood
    case excelent

    var id: Self { self }
}
