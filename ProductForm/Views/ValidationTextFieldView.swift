//
//  ValidationTextFieldView.swift
//  ProductForm
//
//  Created by Leonardo Soares on 16/10/2025.
//

import SwiftUI

struct ValidationTextFieldView: View {

    @State private(set) var text: String
    @State private(set) var message: [String] = []

    @State private var managedText: String = ""
    @State private var isUppercased: Bool = false
    @State private var managedNumber: Int?

    @FocusState private var isFocused: Bool

    let fieldType: FieldType
    let placeholder: String

    let validation: (Bool) -> Void

    var body: some View {
        VStack(alignment: .leading) {
            getView()
                .focused($isFocused)
                .padding(.horizontal)
                .padding(.vertical, 10)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(.mediumRatingForeground)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.white)
                )
                .onChange(of: isFocused) { oldValue, newValue in
                    if !oldValue, newValue {
                        switch fieldType {
                            case .number:
                                validate(managedNumber)
                            case .text(validations: let validations):
                                validate(managedText, with: validations)
                        }
                    }
                }

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

    private func validate(_ value: String, with validations: [ValidationType]?) {
        message.removeAll()
        guard !value.isEmpty else {
            message.append("This field is required.")
            return
        }

        validations?.forEach { validator in
            if let validationMessage = validator.getMessage(value) {
                message.append(validationMessage)
            }
        }

        validation(message.isEmpty)
    }

    func validate(_ value: Int?) {
        message.removeAll()
        if let value {
            text = "\(value)"
        } else {
            message.append("Please enter a number.")
        }

        validation(message.isEmpty)
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
                .onChange(of: managedText) { _, newValue in
                    validate(newValue, with: validations)
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
                    validate(newValue)
                }
                .onAppear {
                    managedNumber = Int(text)
                }
        }
    }
}

#Preview {
    ValidationTextFieldView(
        text: "Name",
        fieldType: .text(),
        placeholder: "Name"
    ) { isValid in
        print("Name is valid?", isValid)
    }

    ValidationTextFieldView(
        text: "leonardo@email.com",
        fieldType: .text(validations: [.email]),
        placeholder: "E-mail"
    ) { isValid in
        print("E-mail is valid?", isValid)
    }

    ValidationTextFieldView(
        text: "",
        fieldType: .number,
        placeholder: "Number"
    ) { isValid in
        print("Number is valid?", isValid)
    }

    ValidationTextFieldView(
        text: "ÁÉÖ",
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
