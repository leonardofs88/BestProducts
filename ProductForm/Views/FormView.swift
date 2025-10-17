//
//  FormView.swift
//  BestProducts
//
//  Created by Leonardo Soares on 17/10/2025.
//

import SwiftUI

struct FormView: View {

    @Injected(\.formViewModel) var formViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                ValidationTextFieldView(
                    text: formViewModel.formModel.name,
                    fieldType: .text(),
                    placeholder: "Name"
                ) { isValid in
                    formViewModel.validateName(isValid)
                }

                ValidationTextFieldView(
                    text: formViewModel.formModel.email,
                    fieldType: .text(validations: [.email]),
                    placeholder: "E-mail"
                ) { isValid in
                    formViewModel.validateEmail(isValid)
                }

                ValidationTextFieldView(
                    text: "\(formViewModel.formModel.number)",
                    fieldType: .number,
                    placeholder: "Number"
                ) { isValid in
                    formViewModel.validateNumber(isValid)
                }

                ValidationTextFieldView(
                    text: formViewModel.formModel.promoCode,
                    fieldType: .text(validations: [.promoCode, .min(3), .max(7)]),
                    placeholder: "Promo Code"
                ) { isValid in
                    formViewModel.validatePromoCode(isValid)
                }

                ValidationDateView(
                    date: formViewModel.formModel.deliveryDate,
                    description: "Delivery Date",
                    dateValidators: [.future, .invalidDays([.monday])]
                ) { isValid in
                    formViewModel.validateDelivery(isValid)
                }

                ValidationPickerView(description: "Evaluation", selection: Evaluation.bad)
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Validation Form")
                        .font(.largeTitle)
                }

                ToolbarItem(placement: .topBarTrailing) {
                    SystemButtom(buttonType: .text("Save"), isDisabled: !formViewModel.formIsValid) {
                        formViewModel.saveForm()
                    }
                }
            }
        }
    }
}

#Preview {
    FormView()
}

import Factory

extension Container {
    var formViewModel: Factory<FormViewModelProtocol> {
        self { FormViewModel() }
    }
}
