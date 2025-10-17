//
//  FormView.swift
//  BestProducts
//
//  Created by Leonardo Soares on 17/10/2025.
//

import SwiftUI

struct FormView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var number: String = ""
    @State private var promoCode: String = ""
    @State private var saveButtonDisabled = true
    @State private var date: Date = Date()

    var body: some View {
        NavigationStack {
            ScrollView {
                ValidationTextFieldView(
                    text: $name,
                    fieldType: .text(),
                    placeholder: "Name"
                ) { isValid in
                    print("Name is valid?", isValid)
                }

                ValidationTextFieldView(
                    text: $email,
                    fieldType: .text(validations: [.email]),
                    placeholder: "E-mail"
                ) { isValid in
                    print("E-mail is valid?", isValid)
                }

                ValidationTextFieldView(
                    text: $number,
                    fieldType: .number,
                    placeholder: "Number"
                ) { isValid in
                    print("Number is valid?", isValid)
                }

                ValidationTextFieldView(
                    text: $promoCode,
                    fieldType: .text(validations: [.promoCode, .min(3), .max(7)]),
                    placeholder: "Promo Code"
                ) { isValid in
                    print("Promo Code is valid?", isValid)
                }

                ValidationDateView(
                    date: $date,
                    description: "Delivery Date",
                    dateValidators: [.future, .invalidDays([.monday])]
                ) { isValid in
                    print("Date is valid: ", isValid)
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
                    SystemButtom(buttonType: .text("Save"), isDisabled: saveButtonDisabled) {

                    }
                }
            }
        }
    }
}

#Preview {
    FormView()
}
