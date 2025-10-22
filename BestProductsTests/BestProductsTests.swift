//
//  BestProductsTests.swift
//  BestProductsTests
//
//  Created by Leonardo Soares on 15/10/2025.
//

import Testing
import Combine
import Foundation
import Factory

struct BestProductsTests {

    @Test func testFiltering() async {
        Container.shared.productRepository.register {
            MockProductRepository()
        }
        
        let viewModel = await MainAppViewModel()
        await viewModel.getProducts()

        #expect(await viewModel.fullProductList.count == 30)
        #expect(await viewModel.filteredProductList.isEmpty)

        await viewModel.filterProducts(with: "red")

        #expect(await viewModel.filteredProductList.count == 2)
    }

}
