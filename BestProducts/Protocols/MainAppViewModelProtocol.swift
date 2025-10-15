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
    var products: [Product] { get }

    func getProducts()
}
