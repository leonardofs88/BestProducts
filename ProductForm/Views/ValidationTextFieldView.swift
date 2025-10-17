//
//  ValidationTextFieldView.swift
//  ProductForm
//
//  Created by Leonardo Soares on 16/10/2025.
//

import SwiftUI

struct ValidationTextFieldView: View {
    @Binding private(set) var text: String
    @State private(set) var message: [String] = []

    @State private var managedText: String = ""
    @State private var isUppercased: Bool = false
    @State private var managedNumber: Int?

    let fieldType: FieldType
    let placeholder: String

    let validation: (Bool) -> Void

    var body: some View {
        VStack(alignment: .leading) {
            getView()
                .padding(.horizontal)
                .padding(.vertical, 10)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(.mediumRatingForeground)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.white)
                )

            if !message.isEmpty {
                ForEach(message, id: \.self) { message in
                    Text(message)
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .font(.callout)
                        .foregroundStyle(.lowRatingForeground)
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
    }

    @ViewBuilder func getView() -> some View {
        switch fieldType {
            case .text(let validations):
                TextField(
                    placeholder,
                    text: $managedText,
                    prompt: Text(placeholder)
                        .font(.title2)
                        .foregroundStyle(.productBackgroundShadow)
                )
                .onChange(of: managedText) { old, newValue in
                    message.removeAll()
                    guard !newValue.isEmpty else {
                        message.append("This field is required.")
                        return
                    }

                    validations?.forEach { validator in
                        if let validationMessage = validator.getMessage(newValue) {
                            message.append(validationMessage)
                        }
                    }

                    validation(message.isEmpty)
                }
                .onAppear {
                    managedText = text
                }
            case .number:
                TextField(
                    placeholder,
                    value: $managedNumber,
                    format: .number,
                    prompt: Text(placeholder)
                        .font(.title2)
                        .foregroundStyle(.productBackgroundShadow)
                )
                .keyboardType(.numberPad)
                .onChange(of: managedNumber, initial: false) { _, newValue in
                    message.removeAll()
                    if let newValue {
                        text = "\(newValue)"
                    } else {
                        message.append("Please enter a number.")
                    }
                    validation(message.isEmpty)
                }
                .onAppear {
                    managedNumber = Int(text)
                }
        }
    }
}

#Preview {
    ValidationTextFieldView(
        text: .constant("Name"),
        fieldType: .text(),
        placeholder: "Name"
    ) { isValid in
        print("Name is valid?", isValid)
    }

    ValidationTextFieldView(
        text: .constant("leonardo@email.com"),
        fieldType: .text(validations: [.email]),
        placeholder: "E-mail"
    ) { isValid in
        print("E-mail is valid?", isValid)
    }

    ValidationTextFieldView(
        text: .constant(""),
        fieldType: .number,
        placeholder: "Number"
    ) { isValid in
        print("Number is valid?", isValid)
    }

    ValidationTextFieldView(
        text: .constant("ÁÉÖ"),
        fieldType: .text(validations: [.promoCode, .min(3), .max(7)]),
        placeholder: "Promo Code"
    ) { isValid in
        print("Promo Code is valid?", isValid)
    }
}

enum FieldType {
    case text(validations: [ValidationType]? = nil)
    case number
}

enum ValidationType: Validator {
    case email
    case promoCode
    case min(Int)
    case max(Int)

    func getMessage(_ value: String?) -> String? {

        guard let value, !value.isEmpty else {
            return "This field is required"
        }

        switch self {
            case .email:
                let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
                let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
                return emailPred.evaluate(with: value) ? nil : "Invalid email format"
            case .promoCode:
                return value.isUppercaseHyphenOnly ? "Promo code must be uppercase and contain only hyphens (-)" : nil
            case .min(let min):
                return value.count < min ? "Minimum \(min) characters required" : nil
            case .max(let max):
                return value.count > max ? "Maximum \(max) characters allowed" : nil
        }
    }
}

protocol Validator: Equatable {
    func getMessage(_ value: String?) -> String?
}
