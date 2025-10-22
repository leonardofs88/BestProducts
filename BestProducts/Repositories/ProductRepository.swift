//
//  ProductRepository.swift
//  BestProducts
//
//  Created by Leonardo Soares on 15/10/2025.
//

import Foundation
import Factory
import Combine

class ProductRepository: ProductRepositoryProtocol {

    @Injected(\.service) private(set) var service

    func getProductList() -> AnyPublisher<ProductWrapper, any Error> {

        guard let request = EndpointRouter.https(.get).getURL(for: .products) else {
            return Fail(outputType: ProductWrapper.self, failure: ServiceError.wrongURL).eraseToAnyPublisher()
        }

        return service.fetchData(for: request)
                    .decode(type: ProductWrapper.self, decoder: JSONDecoder())
                    .eraseToAnyPublisher()
    }
}
