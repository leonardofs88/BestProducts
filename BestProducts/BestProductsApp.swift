//
//  BestProductsApp.swift
//  BestProducts
//
//  Created by Leonardo Soares on 15/10/2025.
//

import SwiftUI

@main
struct BestProductsApp: App {
    static let isRunningUnitTests: Bool = {
        let environment = ProcessInfo().environment
        return (environment["XCTestConfigurationFilePath"] != nil)
    }()

    var body: some Scene {
        WindowGroup {
            if !BestProductsApp.isRunningUnitTests {
                #if PRODUCTS
                MainAppView()
                #elseif FORMS
                FormView()
                #endif
            }
        }
    }
}
