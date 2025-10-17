//
//  ContainerExtension.swift
//  BestProducts
//
//  Created by Leonardo Soares on 15/10/2025.
//

import Factory

// MARK: - Containers for Best Products Target only

extension Container {
    var mainAppViewModel: Factory<MainAppViewModelProtocol> {
        self { MainAppViewModel() }
    }

    var service: Factory<ServiceProtocol> {
        self { Service() }
    }

    var productRepository: Factory<ProductRepositoryProtocol> {
        self { ProductRepository() }
    }
}
