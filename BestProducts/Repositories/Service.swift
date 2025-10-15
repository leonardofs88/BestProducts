//
//  Service.swift
//  BestProducts
//
//  Created by Leonardo Soares on 15/10/2025.
//

import Combine
import Foundation

class Service: ServiceProtocol {

    let urlSession = URLSession(configuration: .default)

    func fetchData<T: Codable>(for request: URLRequest) -> AnyPublisher<T, any Error> {
        urlSession
            .dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .tryMap { element in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw ServiceError.badResponse
                }

                return element.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
