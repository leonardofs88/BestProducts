//
//  MockProductRepository.swift
//  BestProducts
//
//  Created by Leonardo Soares on 20/10/2025.
//

import Foundation
import Combine
import Factory

class MockProductRepository: ProductRepositoryProtocol {
    @Injected(\.service) var service

    func getProductList() -> AnyPublisher<ProductWrapper, any Error> {
        guard let request = MockEndpointRouter.file.getURL(for: .products) else {
            return Fail(outputType: ProductWrapper.self, failure: ServiceError.wrongURL).eraseToAnyPublisher()
        }
        return service.fetchData(for: request)
    }
}
