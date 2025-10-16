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
    private(set) var product: Product

    var body: some View {
        VStack {
            VStack(alignment: .center) {
                if product.imagesURLs.isEmpty {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                } else {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(product.imagesURLs, id: \.self) { imageURL in
                                AsyncImage(url: imageURL) { phase in
                                    if let image = phase.image {
                                        image // Displays the loaded image.
                                            .resizable()
                                            .scaledToFit()
                                    } else if phase.error != nil {
                                        Color.red // Indicates an error.
                                    } else {
                                        Color.blue // Acts as a placeholder.
                                    }
                                }
                            }
                        }
                    }
                    .scrollTargetBehavior(.paging)
                }
            }

            ScrollView {
                Color.clear
                    .scrollOffset(namespace: namespace)

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
            } //: ScrollView
            .onPreferenceChange(ViewOffsetKey.self) { value in
                if value.y < scrollOffset.y {
                    print("Scrolling Up")
                } else if value.y > scrollOffset.y {
                    print("Scrolling Down")
                }
                scrollOffset = value
            }
            .coordinateSpace(name: namespace)
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
