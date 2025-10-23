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
        #expect(await viewModel.filteredProductList.count == 30)

        await viewModel.filterProducts(with: "red")

        #expect(await viewModel.filteredProductList.count == 2)
    }

    @Test func testFilteringWithUnsequencedTerms() async {
        Container.shared.productRepository.register {
            MockProductRepository()
        }

        let viewModel = await MainAppViewModel()
        await viewModel.getProducts()

        #expect(await viewModel.fullProductList.count == 30)
        #expect(await viewModel.filteredProductList.count == 30)

        await viewModel.filterProducts(with: "lipstick")
        await viewModel.filterProducts(with: "red")

        #expect(await viewModel.filteredProductList.count == 2)
    }

    @Test func testFilteringTermsDeleted() async throws {
        Container.shared.productRepository.register {
            MockProductRepository()
        }

        let viewModel = await MainAppViewModel()
        await viewModel.getProducts()

        #expect(await viewModel.fullProductList.count == 30)
        #expect(await viewModel.filteredProductList.count == 30)

        await viewModel.filterProducts(with: "at")
        #expect(await viewModel.filteredProductList.count == 3)
        await viewModel.filterProducts(with: "red")
        #expect(await viewModel.filteredProductList.count == 5)
        let tagID = try #require(await viewModel.termTags.first { $0.term == "at" }?.id)
        await viewModel.removeTag(tagID)
        #expect(await viewModel.filteredProductList.count == 2)
    }

}
