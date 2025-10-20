//
//  MockMainAppViewModel.swift
//  BestProducts
//
//  Created by Leonardo Soares on 20/10/2025.
//

import Combine
import Foundation
import Factory

class MockMainAppViewModel: MainAppViewModelProtocol {
    @Injected(\.productRepository) var productRepository

    lazy var cancellables: Set<AnyCancellable> = []

    var fullProductList: [Product] = []

    var filteredProductList: [Product] = []

    var termTags: [TermTag] = []

    func getProducts() {
        productRepository.getProductList()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print(error.localizedDescription)
                }
            } receiveValue: { result in

            }
            .store(in: &cancellables )

    }

    func filterProducts(with term: String, filter: FilterOption) {

    }

    func removeTag(_ id: UUID) {

    }

    func clearTags() {

    }
}
