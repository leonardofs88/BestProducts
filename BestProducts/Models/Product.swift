//
//  Product.swift
//  BestProducts
//
//  Created by Leonardo Soares on 15/10/2025.
//

import Foundation

struct ProductWrapper: Codable {
    var products: [Product]
}

struct Product: Identifiable, Codable {
    var id: Int
    var title: String
    var price: Double
    var discount: Double
    var rating: Double
    var stock: Int
    var images: [String]

    var imagesURLs: [URL] {
        images.compactMap { URL(string: $0) }
    }

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
        case discount = "discountPercentage"
        case rating
        case stock
        case images
    }
}
