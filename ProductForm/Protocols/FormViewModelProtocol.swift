//
//  FormViewModelProtocol.swift
//  BestProducts
//
//  Created by Leonardo Soares on 17/10/2025.
//

import Foundation

protocol FormViewModelProtocol {
    var formModel: FormModel { get }
    var formIsValid: Bool { get }

    var nameIsValid: Bool { get }
    var emailIsValid: Bool { get }
    var numberIsValid: Bool { get }
    var promoCodeIsValid: Bool { get }
    var deliveryDateIsValid: Bool { get }

    func validateName(_ value: Bool)
    func validateEmail(_ value: Bool)
    func validateNumber(_ value: Bool)
    func validatePromoCode(_ value: Bool)
    func validateDelivery(_ value: Bool)
    func saveForm()
}
