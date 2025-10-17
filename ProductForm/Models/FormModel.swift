//
//  FormModel.swift
//  BestProducts
//
//  Created by Leonardo Soares on 17/10/2025.
//

import Foundation

struct FormModel: Codable, Identifiable {
    var id: UUID { UUID() }
    var name: String
    var email: String
    var number: Int
    var promoCode: String
    var deliveryDate: Date
    var evaluation: Evaluation
}
