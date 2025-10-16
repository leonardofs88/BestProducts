//
//  DetailsView.swift
//  BestProducts
//
//  Created by Leonardo Soares on 16/10/2025.
//

import SwiftUI

struct DetailsView: View {
    @Namespace private var namespace
    @State private var scrollOffset: CGPoint = .zero
    @State private var scrollHeight: CGFloat = 400
    private(set) var product: Product

    private(set) var minHeight: CGFloat = 300
    private(set) var maxHeight: CGFloat = 400

    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(product.imagesURLs, id: \.absoluteString) { image in
                        AsyncImage(url: image) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .scaledToFill()
                            }
                        }
                    }
                }
            }
            .frame(
                height: scrollHeight
            )
            .scrollTargetBehavior(.paging)

            ScrollView {
                Color.clear
                    .scrollOffset(namespace: namespace)

                HStack {
                    Text("Name:")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Spacer()
                    Text(product.title)
                        .font(.title2)
                }
                .padding()

                HStack {
                    Text("Price:")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Spacer()
                    Text(product.price, format: .currency(code: "EUR"))
                        .font(.title2)
                }
                .padding()
                HStack {
                    Text("Discount:")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Spacer()
                    Text(product.discount, format: .percent)
                        .font(.title2)
                }
                .padding()
                HStack {
                    Text("Stock:")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Spacer()
                    Text(product.stock, format: .number)
                        .font(.title2)
                }
                .padding()
                HStack {
                    Text("Rating:")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Spacer()
                    RatingView(rating: product.rating)
                }
                .padding()
            } //: ScrollView
            .coordinateSpace(name: namespace)
            .onPreferenceChange(ViewOffsetKey.self, perform: { value in
                if value.origin.y < scrollOffset.y {
                    let scrollingValue = scrollHeight + value.origin.y
                    scrollHeight = scrollingValue < minHeight ? minHeight : scrollingValue
                } else if value.origin.y > scrollOffset.y {
                    let scrollingValue = scrollHeight + value.origin.y
                    scrollHeight = scrollingValue > maxHeight ? maxHeight : scrollingValue
                }

            })
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
            images: [
                "https://cdn.dummyjson.com/product-images/fragrances/dolce-shine-eau-de/1.webp",
                "https://cdn.dummyjson.com/product-images/fragrances/dolce-shine-eau-de/2.webp",
                "https://cdn.dummyjson.com/product-images/fragrances/dolce-shine-eau-de/3.webp"
            ]
        )
    )
}
