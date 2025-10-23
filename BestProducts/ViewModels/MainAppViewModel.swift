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

    @ObservationIgnored @Injected(\.filterManager) var filterManager

    @ObservationIgnored @Injected(\.productRepository) private(set) var productRepository

    @ObservationIgnored private(set) lazy var cancellables: Set<AnyCancellable> = []

    private(set) var fullProductList: [Product] = []
    private(set) var filteredProductList: [Product] = []
    var termTags: [TermTag] = []

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
                self?.fullProductList = wrapper.products
                self?.filterProducts()
            }
            .store(in: &cancellables)
    }

    func filterProducts(with term: String = "") {
        let termTag = TermTag(term: term.trimmingCharacters(in: .whitespacesAndNewlines))

        var bufferTermTags: [TermTag] = termTags

        bufferTermTags.append(termTag)

        if term.last == " ", !termTags.contains(where: { $0.term == term }) {
            termTags.append(termTag)
        }

        let terms = term.isEmpty ? termTags.compactMap(\.term) : bufferTermTags.compactMap { $0.term != "" ? $0.term : nil }

        fullProductList.filter { product in
            terms.contains(
                where: {
                    (product.title.range(of: $0, options: filterManager.getFilters()) != nil)
                    && (product.description.range(of: $0, options: filterManager.getFilters()) != nil)
                })
        }
        .map { $0 }
        .publisher
        .collect()
        .receive(on: DispatchQueue.main)
        .sink(
            receiveValue: { [weak self] items in
                guard let self else { return }
                filteredProductList =  if !items.isEmpty {
                    items
                } else {
                    terms.isEmpty ? fullProductList : []
                }
            })
        .store(in: &cancellables)
    }

    func removeTag(_ id: UUID) {
        termTags.removeAll { $0.id == id }
        filterProducts()

    }

    func clearTags() {
        termTags.removeAll()
        filterProducts()

    }
}
