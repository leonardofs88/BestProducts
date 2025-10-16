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

                if isShowingSearch {
                    VStack {
                        SearchView(
                            termTags: mainAppViewModel.termTags
                        ) { searchTerm, filter in
                            mainAppViewModel.filterProducts(
                                with: searchTerm,
                                filter: filter
                            )
                        } deleteTag: { mainAppViewModel.removeTag($0) }
                        clearTags: {
                            mainAppViewModel.clearTags()
                        }
                        .transition(.move(edge: .top))
                    }
                }
                ScrollView {
                    LazyVStack {
                        ForEach(mainAppViewModel.filteredProductList) { item in
                            ProductListView(product: item)
                                .padding(2)
                        }
                    }
                }
            }
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Products")
                        .font(.largeTitle)
                }

                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button {
                        withAnimation(.bouncy(duration: 0.3)) {
                            isShowingSearch.toggle()
                        }
                    } label: {
                        Image(systemName: .magnifyingGlass)
                            .foregroundStyle(.productBackgroundShadow)
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
