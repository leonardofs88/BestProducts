//
//  DetailsView.swift
//  BestProducts
//
//  Created by Leonardo Soares on 16/10/2025.
//

import SwiftUI

struct DetailsView: View {
    private(set) var product: Product

    var body: some View {
        List {
            VStack(alignment: .center) {
                if product.imagesURLs.isEmpty {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200)
                } else {
                    ForEach(product.imagesURLs, id: \.self) { imageURL in
                        AsyncImage(url: imageURL) { phase in
                            if let image = phase.image {
                                image // Displays the loaded image.
                            } else if phase.error != nil {
                                Color.red // Indicates an error.
                            } else {
                                Color.blue // Acts as a placeholder.
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            HStack {
                Text("Name:")
                    .fontWeight(.bold)
                Spacer()
                Text(product.title)
            }
            HStack {
                Text("Price:")
                    .fontWeight(.bold)
                Spacer()
                Text(product.price, format: .currency(code: "EUR"))
            }
            HStack {
                Text("Discount:")
                    .fontWeight(.bold)
                Spacer()
                Text(product.discount, format: .percent)
            }
            HStack {
                Text("Stock:")
                    .fontWeight(.bold)
                Spacer()
                Text(product.stock, format: .number)
            }
            HStack {
                Text("Rating:")
                    .fontWeight(.bold)
                Spacer()
                RatingView(rating: product.rating)
            }
        }

    }
}

#Preview {
    DetailsView(
        product: Product(
            id: 1,
            title: "NewProduct",
            description: "Description",
            price: 20.22,
            discount: 0.3,
            rating: 3.3,
            stock: 6,
            images: []
        )
    )
}
