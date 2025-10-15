//
//  ServiceProtocol.swift
//  BestProducts
//
//  Created by Leonardo Soares on 15/10/2025.
//

import Combine
import Foundation

protocol ServiceProtocol {
    func fetchData<T: Codable>(for request: URLRequest) -> AnyPublisher<T, any Error>
}
