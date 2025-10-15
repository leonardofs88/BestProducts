//
//  MainAppView.swift
//  BestProducts
//
//  Created by Leonardo Soares on 15/10/2025.
//

import SwiftUI
import CoreData
import Factory

struct MainAppView: View {

    @Injected(\.mainAppViewModel) private var mainAppViewModel

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(mainAppViewModel.products) { item in
                        ProductView(product: item)
                            .padding(2)
                    }
                }
            }
            .navigationTitle("Products")
            .padding()
        }
        .onAppear {
            mainAppViewModel.getProducts()
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    MainAppView()
}
