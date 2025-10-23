//
//  FilterManagerProtocol.swift
//  BestProducts
//
//  Created by Leonardo Soares on 23/10/2025.
//

import Foundation

protocol FilterManagerProtocol {
    var option: FilterOption { get }
    @MainActor func setOption(caseInsensitive: Bool, diacriticInsesitive: Bool) async
    func getFilters() -> String.CompareOptions
}
