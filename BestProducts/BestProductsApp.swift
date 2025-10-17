//
//  BestProductsApp.swift
//  BestProducts
//
//  Created by Leonardo Soares on 15/10/2025.
//

import SwiftUI

@main
struct BestProductsApp: App {

    var body: some Scene {
        WindowGroup {
            #if PRODUCTS
            MainAppView()
            #elseif FORMS
            FormView()
            #endif
        }
    }
}
