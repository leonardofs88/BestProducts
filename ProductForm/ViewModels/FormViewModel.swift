//
//  FormViewModel.swift
//  BestProducts
//
//  Created by Leonardo Soares on 17/10/2025.
//

import SwiftUI

@Observable
class FormViewModel: FormViewModelProtocol {

    private(set) var formModel: FormModel = FormModel(
        name: "",
        email: "",
        number: 0,
        promoCode: "",
        deliveryDate: Date(),
        evaluation: .bad
    )

    private(set) var nameIsValid: Bool = false
    private(set) var emailIsValid: Bool = false
    private(set) var numberIsValid: Bool = false
    private(set) var promoCodeIsValid: Bool = false
    private(set) var deliveryDateIsValid: Bool = false

    var formIsValid: Bool = false

    func validateName(_ value: Bool) {
        nameIsValid = value
        evaluateForm()
    }

    func validateEmail(_ value: Bool) {
        emailIsValid = value
        evaluateForm()
    }

    func validateNumber(_ value: Bool) {
        numberIsValid = value
        evaluateForm()
    }

    func validatePromoCode(_ value: Bool) {
        promoCodeIsValid = value
        evaluateForm()
    }

    func validateDelivery(_ value: Bool) {
        deliveryDateIsValid = value
        evaluateForm()
    }
    
    func saveForm() {
        if formIsValid {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(formModel) {
                let defaults = UserDefaults.standard
                defaults.set(encoded, forKey: "\(formModel.name)")
                print("Success saving")
            } else {
                print("Failed saving")
            }
        }
    }

    private func evaluateForm() {
        if !nameIsValid || !emailIsValid || !numberIsValid || !promoCodeIsValid || !deliveryDateIsValid {
            formIsValid = false
        } else {
            formIsValid = true
        }
    }
}
