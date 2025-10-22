//
//  Service.swift
//  BestProducts
//
//  Created by Leonardo Soares on 15/10/2025.
//

import Combine
import Foundation

class Service: ServiceProtocol {

    let urlSession: URLSession? = URLSession(configuration: .default)

    func fetchData(for request: URLRequest) -> AnyPublisher<Data, any Error> {
        guard let urlSession else {
            return Fail(
                outputType: Data.self,
                failure: ServiceError.invalidSession
            ).eraseToAnyPublisher()
        }
        return urlSession
            .dataTaskPublisher(for: request)
            .map(\.data)
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}
