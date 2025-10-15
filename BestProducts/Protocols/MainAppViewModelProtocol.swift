//
//  MainAppViewModelProtocol.swift
//  BestProducts
//
//  Created by Leonardo Soares on 15/10/2025.
//

import Foundation

protocol MainAppViewModelProtocol {
    var products: [Product] { get }

    func getProducts()
}
