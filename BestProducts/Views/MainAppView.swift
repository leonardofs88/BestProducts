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

    @State private(set) var isShowingSearch = false

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    LazyVStack {
                        ForEach(mainAppViewModel.products) { item in
                            ProductListView(product: item)
                                .padding(2)
                        }
                    }
                }

                if isShowingSearch {
                    VStack {
                        SearchView { searchTerm in
                            print(searchTerm)
                        }
                        .transition(.move(edge: .bottom))
                    }
                }
            }
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Products")
                        .font(.largeTitle)
                }

                ToolbarItemGroup(placement: .bottomBar) {
                    SwitchButton(buttonType: .image(.magnifyingGlass)) { isPressed in
                        withAnimation(.bouncy(duration: 0.3)) {
                            isShowingSearch = isPressed
                        }
                    }
                }
            })
            .toolbarBackground(.white, for: .bottomBar, .navigationBar)
            .padding()
        }
        .onAppear {
            mainAppViewModel.getProducts()
        }
    }
}

#Preview {
    MainAppView()
}
