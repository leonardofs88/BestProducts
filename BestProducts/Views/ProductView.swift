//
//  ProductView.swift
//  BestProducts
//
//  Created by Leonardo Soares on 15/10/2025.
//

import SwiftUI

struct ProductView: View {

    @State var product: Product

    var body: some View {
        HStack {
            VStack {
                Text(product.name ?? "Name Unavailable")
            }
            .padding(2)

            HStack {
                Text(product.rating, format: .number)
                Image(systemName: .star)
            }
            .foregroundStyle(.white)
            .padding(.horizontal, 6)
            .padding(.vertical, 3)
            .background(
                ratingColor()
                    .clipShape(Capsule())
                )

        }
        .padding()
        .background(
            Color.productBackground
                .clipShape(RoundedRectangle(cornerRadius: 12))
        )
    }

    func ratingColor() -> Color {
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
    ProductView(product: Product(context: PersistenceController.preview.container.viewContext))
}

enum RatingType {
    case low
    case medium
    case high

    var color: Color {
        switch self {
        case .low:
            return .red
        case .medium:
            return .yellow
        case .high:
            return .green
        }
    }
}

extension String {
    static var star : String {
        "star.fill"
    }
}
