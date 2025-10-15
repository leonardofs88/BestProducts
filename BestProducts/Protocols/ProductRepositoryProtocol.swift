//
//  ProductRepositoryProtocol.swift
//  BestProducts
//
//  Created by Leonardo Soares on 15/10/2025.
//

import Foundation
import Combine

protocol ProductRepositoryProtocol {
    var service: any ServiceProtocol { get }
    func getProductList() -> AnyPublisher<ProductWrapper, any Error>
}
