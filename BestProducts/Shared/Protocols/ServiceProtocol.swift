//
//  ServiceProtocol.swift
//  BestProducts
//
//  Created by Leonardo Soares on 15/10/2025.
//

import Combine
import Foundation

protocol ServiceProtocol {
    var urlSession: URLSession? { get }
    func fetchData(for request: URLRequest) -> AnyPublisher<Data, any Error>
}
