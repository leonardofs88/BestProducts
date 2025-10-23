//
//  ContainerExtension.swift
//  BestProducts
//
//  Created by Leonardo Soares on 15/10/2025.
//

import Factory

// MARK: - Containers for Best Products Target only

extension Container {
    @MainActor
    var mainAppViewModel: Factory<MainAppViewModelProtocol> {
        self { @MainActor in MainAppViewModel() }
    }

    var service: Factory<ServiceProtocol> {
        self { Service() }
    }

    var productRepository: Factory<ProductRepositoryProtocol> {
        self { ProductRepository() }
    }

    var filterManager: Factory<FilterManagerProtocol> {
        self { FilterManager() }
    }
}
