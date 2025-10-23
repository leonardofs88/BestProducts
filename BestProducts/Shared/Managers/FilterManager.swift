//
//  FilterManager.swift
//  BestProducts
//
//  Created by Leonardo Soares on 23/10/2025.
//

import Foundation

class FilterManager: FilterManagerProtocol {
    private(set) var option: FilterOption = .all

    func setOption(
        caseInsensitive: Bool,
        diacriticInsesitive: Bool
    ) async {
        option = switch true {
                case caseInsensitive && diacriticInsesitive:
                        .all
                case diacriticInsesitive:
                        .diacriticInsensitive
                case caseInsensitive:
                        .caseInsensitive
                default:
                        .none
                }
    }

    func getFilters() -> String.CompareOptions {
        switch option {
        case .caseInsensitive:
            [.caseInsensitive]
        case .diacriticInsensitive:
            [.diacriticInsensitive]
        case .all:
            [.caseInsensitive, .diacriticInsensitive]
        case .none:
            []
        }
    }
}
