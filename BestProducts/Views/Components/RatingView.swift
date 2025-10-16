//
//  RatingView.swift
//  BestProducts
//
//  Created by Leonardo Soares on 16/10/2025.
//

import SwiftUI

struct RatingView: View {
    var rating: Double
    var body: some View {
        HStack {
            Text(rating, format: .number)
            Image(systemName: .star)
        }
        .foregroundStyle(ratingColorForeground())
        .padding(.horizontal, 6)
        .padding(.vertical, 3)
        .background(
            ratingColorBackground()
                .clipShape(Capsule())
        )
    }

    func ratingColorForeground() -> Color {
        switch rating {
        case ..<3:
            return .lowRatingForeground
        case 3..<4:
            return .mediumRatingForeground
        default:
            return .highRatingForeground
        }
    }

    func ratingColorBackground() -> Color {
        switch rating {
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
    RatingView(rating: 2.3)
    RatingView(rating: 3.4)
    RatingView(rating: 4.2)
}
