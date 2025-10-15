//
//  SearchView.swift
//  BestProducts
//
//  Created by Leonardo Soares on 15/10/2025.
//

import SwiftUI

struct SearchView: View {
    @State private(set) var searchTerm: String = ""

    private(set) var searchAction: (String) -> Void

    var body: some View {
        VStack(alignment: .leading) {
            TextField("Search", text: $searchTerm)
                .padding(.top, 5)

            Divider()
                .background(.mediumRatingForeground)

            HStack {
                SwitchButton(buttonType: .image("textformat.size")) { isPressed in
                    print("filter by font size? ", isPressed)
                }

                SwitchButton(buttonType: .text("àéö")) { isPressed in
                    print("filter by font accentuation? ", isPressed)
                }
            }
            .padding(.top, 5)
        }
        .padding()
        .onChange(of: searchTerm) { _, newTerm in
            searchAction(newTerm)
        }
    }
}

#Preview {
    SearchView { searchTerm in
        print("search term: \(searchTerm)")
    }
}
