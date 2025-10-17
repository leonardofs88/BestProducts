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
    @State private var isNameValid: Bool = true
    @State private var isEmailValid: Bool = true
    @State private var isNumberValid: Bool = true

    var body: some View {
        NavigationStack {
            ScrollView {
                ValidationTextFieldView(
                    text: $name,
                    isValid: $isNameValid,
                    validationType: .empty,
                    placeholder: "Name"
                )
                
                ValidationTextFieldView(
                    text: $email,
                    isValid: $isEmailValid,
                    validationType: .email,
                    placeholder: "E-Mail"
                )

                ValidationTextFieldView(
                    text: $number,
                    isValid: $isNumberValid,
                    validationType: .number,
                    placeholder: "Number"
                )
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Validated Form")
                        .font(.largeTitle)

                }
            }
        }
    }
}

#Preview {
    FormView()
}
