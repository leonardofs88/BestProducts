//
//  ProductListView.swift
//  BestProducts
//
//  Created by Leonardo Soares on 15/10/2025.
//

import SwiftUI

struct ProductListView: View {
    @Environment(\.colorSchemeContrast) private var colorSchemeContrast

    @State private(set) var product: Product
    @State private var tapped: Bool = false

    var body: some View {
        HStack {
            NavigationLink(value: Router.details(product)) {
                Text(product.title)
                    .fontWeight(.medium)
                .padding(2)

                Spacer()
                RatingView(rating: product.rating)
                Image(systemName: .chevronRight)
            }
            .foregroundStyle(.productBackgroundShadow)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            tapped = true
            withAnimation(.bouncy) {
                tapped = false
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.productBackground)
                .shadow(
                    color: Color.productBackgroundShadow,
                    radius: 0,
                    y: tapped ? 1 : 3
                )
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .fill(.clear)
                .stroke(.productBackgroundShadow, lineWidth: 1)
        )
        .scaleEffect(tapped ? 0.98 : 1)
    }
}

#Preview {
    ProductListView(
        product: Product(
            id: 1,
            title: "First product",
            description: "Some product Description",
            price: 10.0,
            discount: 2.0,
            rating: 3.2,
            stock: 2,
            images: []
        )
    )

    ProductListView(
        product: Product(
            id: 2,
            title: "Second product",
            description: "One product Description",
            price: 10.0,
            discount: 2.0,
            rating: 4.1,
            stock: 2,
            images: []
        )
    )

    ProductListView(
        product: Product(
            id: 3,
            title: "First product",
            description: "Last product Description",
            price: 10.0,
            discount: 2.0,
            rating: 2.0,
            stock: 2,
            images: []
        )
    )
}

enum Router: Hashable {
    case details(Product)
}
