//
//  MainAppViewModel.swift
//  BestProducts
//
//  Created by Leonardo Soares on 15/10/2025.
//

import SwiftUI
import Factory
import Combine

@Observable
class MainAppViewModel: MainAppViewModelProtocol {

    @ObservationIgnored @Injected(\.productRepository) private(set) var productRepository

    @ObservationIgnored private(set) lazy var cancellables: Set<AnyCancellable> = []

    var products: [Product] = []

    func getProducts() {
        productRepository.getProductList()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: ", error)
                }
            } receiveValue: { [weak self] wrapper in
                self?.products = wrapper.products
            }
            .store(in: &cancellables)

    }
}

import Foundation

protocol ProductRepositoryProtocol {
    var service: any ServiceProtocol { get }
    func getProductList() -> AnyPublisher<ProductWrapper, any Error>
}

class ProductRepository: ProductRepositoryProtocol {

    @Injected(\.service) private(set) var service

    func getProductList() -> AnyPublisher<ProductWrapper, any Error> {

        guard let request = EndpointRouter.https.getURL(for: .products) else {
            return Fail(outputType: ProductWrapper.self, failure: ServiceError.wrongURL).eraseToAnyPublisher()
        }

        return service.fetchData(for: request)
    }
}
