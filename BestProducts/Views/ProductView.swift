//
//  ProductView.swift
//  BestProducts
//
//  Created by Leonardo Soares on 15/10/2025.
//

import SwiftUI

struct ProductView: View {
    @Environment(\.colorSchemeContrast) private var colorSchemeContrast

    @State private(set) var product: Product
    @State private var tapped: Bool = false

    var body: some View {
        HStack {
            Text(product.title)
                .fontWeight(.medium)
            .padding(2)

            Spacer()
            HStack {
                Text(product.rating, format: .number)
//                    .fontWeight(.)
                Image(systemName: .star)
            }
            .foregroundStyle(ratingColorForeground())
            .padding(.horizontal, 6)
            .padding(.vertical, 3)
            .background(
                ratingColorBackground()
                    .clipShape(Capsule())
                )
            Image(systemName: .chevronRight)

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

    func ratingColorForeground() -> Color {
        switch product.rating {
        case ..<3:
            return .lowRatingForeground
        case 3..<4:
                return .mediumRatingForeground
        default:
            return .highRatingForeground
        }
    }

    func ratingColorBackground() -> Color {
        switch product.rating {
        case ..<3:
            return .lowRating
        case 3..<4:
            return .mediumRating
        default:
            return .highRating
        }
    }
}

#Preview {
    ProductView(
        product: Product(
            id: 1,
            title: "First product",
            price: 10.0,
            discount: 2.0,
            rating: 3.2,
            stock: 2,
            images: []
        )
    )

    ProductView(
        product: Product(
            id: 2,
            title: "Second product",
            price: 10.0,
            discount: 2.0,
            rating: 4.1,
            stock: 2,
            images: []
        )
    )

    ProductView(
        product: Product(
            id: 3,
            title: "First product",
            price: 10.0,
            discount: 2.0,
            rating: 2.0,
            stock: 2,
            images: []
        )
    )
}
