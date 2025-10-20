//
//  MockService.swift
//  BestProducts
//
//  Created by Leonardo Soares on 20/10/2025.
//

import Foundation
import Combine

class MockService: ServiceProtocol {

    let urlSession = URLSession(configuration: .default)

    func fetchData<T: Codable>(for request: URLRequest) -> AnyPublisher<T, any Error> {
        urlSession
            .dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .tryMap { element in
                return element.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
