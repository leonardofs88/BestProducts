//
//  ValidationTextFieldView.swift
//  ProductForm
//
//  Created by Leonardo Soares on 16/10/2025.
//

import SwiftUI

struct ValidationTextFieldView: View {
    @Binding private(set) var text: String
    @Binding private(set) var isValid: Bool
    @State private(set) var validationType: ValidationType
    @State private(set) var message: String?

    @State private var managedText: String = ""
    @State private var managedNumber: Int?

    let placeholder: String

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

            if let message {
                Text(message)
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .font(.callout)
                    .foregroundStyle(.lowRatingForeground)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
    }

    @ViewBuilder func getView() -> some View {
        switch validationType {
            case .email, .empty, .promoCode(min: _, max: _):
                TextField(
                    placeholder,
                    text: $managedText,
                    prompt: Text(placeholder)
                        .font(.title2)
                        .foregroundStyle(.productBackgroundShadow)
                )
                .onChange(of: managedText, initial: false) { _, newValue in
                    validate(newValue)
                    if isValid {
                        text = managedText
                    }
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
                    validate("\(newValue)")
                }
                .onAppear {
                    managedNumber = Int(text)
                }
        }
    }

    func validate(_ value: String) {
        message = validationType.getMessage(value)
        isValid = message != nil
    }
}

#Preview {
    ValidationTextFieldView(
        text: .constant("Name"),
        isValid: .constant(true),
        validationType: .empty,
        placeholder: "Name"
    )


    ValidationTextFieldView(
        text: .constant("email@email.co"),
        isValid: .constant(true),
        validationType: .email,
        placeholder: "E-Mail"
    )

    ValidationTextFieldView(
        text: .constant(""),
        isValid: .constant(true),
        validationType: .number,
        placeholder: "Number"
    )
}

enum ValidationType {
    case empty
    case email
    case number
    case promoCode(min: Int, max: Int)

    func getMessage(_ value: String?) -> String? {

        guard let value, !value.isEmpty else {
            return "This field is required"
        }

        switch self {
            case .empty, .number:
                return value == "" ? "This field is required" : nil
            case .email:
                let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
                let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
                return emailPred.evaluate(with: value) ? nil : "Invalid email format"
            case .promoCode(min: let min, max: let max):
                return value.count >= min && value.count <= max ? nil : "Promo code is not in the range"
        }
    }
}

enum InvalidDateReason {
    case invalidDay
    case future
}

enum InvalidInputReason {
    case invalidLength(min: Int, max: Int)
    case invalidFormat
}
