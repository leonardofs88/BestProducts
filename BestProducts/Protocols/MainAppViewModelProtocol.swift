//
//  MainAppViewModelProtocol.swift
//  BestProducts
//
//  Created by Leonardo Soares on 15/10/2025.
//

import Foundation
import Combine

protocol MainAppViewModelProtocol {
    var productRepository: ProductRepositoryProtocol { get }
    var cancellables: Set<AnyCancellable> { get }
    var fullProductList: [Product] { get }
    var filteredProductList: [Product] { get }
    var termTags: [TermTag] { get set }

    func getProducts()
    func filterProducts(with term: String, filter: FilterOption)
    func removeTag(_ id: UUID)
    func clearTags()
}
