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

    func filterProducts(with term: String = "", filter: FilterOption = .all) {
        let termTag = TermTag(term: term.trimmingCharacters(in: .whitespacesAndNewlines))

        let filterOptions: String.CompareOptions =  switch filter {
        case .caseInsensitive:
            [.caseInsensitive]
        case .diacriticInsensitive:
            [.diacriticInsensitive]
        case .all:
            [.caseInsensitive, .diacriticInsensitive]
        case .none:
            []
        }

        var bufferTermTags: [TermTag] = termTags

        print(filterOptions)
        bufferTermTags.append(termTag)

        if term.last == " ", !termTags.contains(where: { $0.term == term }) {
            termTags.append(termTag)
        }

        let terms = bufferTermTags.compactMap { $0.term != "" ? $0.term : nil }

        Task { @MainActor in
            filteredProductList = if terms.isEmpty {
                fullProductList
            } else {
                fullProductList.filter({ $0.title.range(of: term, options: filterOptions) != nil })
            }
        }
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

extension String {
    func contains(_ strings: [String], options: String.CompareOptions? = nil) -> Bool {
        strings.contains { contains($0) }
    }
}

enum FilterOption {
    case caseInsensitive
    case diacriticInsensitive
    case all
    case none
}
