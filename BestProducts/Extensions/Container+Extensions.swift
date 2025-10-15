//
//  ContainerExtension.swift
//  BestProducts
//
//  Created by Leonardo Soares on 15/10/2025.
//

import Factory

extension Container {
    var mainAppViewModel: Factory<MainAppViewModelProtocol> {
        Factory(self) { MainAppViewModel() }
    }
}
