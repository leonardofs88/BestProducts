//
//  Product.swift
//  BestProducts
//
//  Created by Leonardo Soares on 15/10/2025.
//

import Foundation

struct Product: Identifiable, Codable {
    var id: UUID
    var title: String
    var price: Double
    var discount: Double
    var rating: Double
    var stock: Int
    var images: [String]

    var imagesURLs: [URL] {
        images.compactMap { URL(string: $0) }
    }
}
