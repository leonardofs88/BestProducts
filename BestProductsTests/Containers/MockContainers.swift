//
//  MockContainers.swift
//  BestProducts
//
//  Created by Leonardo Soares on 19/10/2025.
//

import Factory

extension Container {
    var mainAppViewModel: Factory<MainAppViewModelProtocol> {
        self { MockMainAppViewModel() }
    }

    var service: Factory<ServiceProtocol> {
        self { MockService() }
    }

    var productRepository: Factory<ProductRepositoryProtocol> {
        self { MockProductRepository() }
    }
}
