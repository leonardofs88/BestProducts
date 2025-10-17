//
//  ValidationDateView.swift
//  BestProducts
//
//  Created by Leonardo Soares on 17/10/2025.
//

import SwiftUI

struct ValidationDateView: View {

    @State private(set) var message: [String] = []

    @State private(set) var date: Date
    @State private(set) var managedDate: Date = Date()

    let description: String
    let dateValidators: [DateValidation]
    let validation: (Bool) -> Void

    var body: some View {
        VStack(alignment: .leading) {
            DatePicker(
                selection: $managedDate,
                displayedComponents: [.date]
            ) {
                Text(description)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.productBackgroundShadow)
            }
            .onChange(of: managedDate, { _, newValue in
                message.removeAll()
                dateValidators.forEach { validator in
                    if let validationMessage = validator.getMessage(newValue) {
                        message.append(validationMessage)
                    }
                }

                validation(message.isEmpty)
            })
            .onAppear {
                managedDate = date
            }
            .padding(.horizontal)
            .padding(.vertical, 10)

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
}

#Preview {
    ValidationDateView(
        date: Date(),
        description: "Delivery Date (not monday)",
        dateValidators: [.invalidDays([.monday])]
    ) { isValid in
        print("Date is valid: ", isValid)
    }

    ValidationDateView(
        date: Date(),
        description: "Delivery Date (not future)",
        dateValidators: [.future]
    ) { isValid in
        print("Date is valid: ", isValid)
    }

    ValidationDateView(
        date: Date(),
        description: "Delivery Date (combined)",
        dateValidators: [.future, .invalidDays([.monday])]
    ) { isValid in
        print("Date is valid: ", isValid)
    }
}

enum DateValidation {

    case invalidDays([DaysOfWeek])
    case future

    enum DaysOfWeek: Int {
        case sunday = 1, monday, tuesday, wednesday, thursday, friday, saturday

        func getDescription() -> String {
            switch self {
                case .sunday: return "Sunday"
                case .monday: return "Monday"
                case .tuesday: return "Tuesday"
                case .wednesday: return "Wednesday"
                case .thursday: return "Thursday"
                case .friday: return "Friday"
                case .saturday: return "Saturday"
            }
        }
    }

    func getMessage(_ value: Date) -> String? {
        switch self {
            case .invalidDays(let days):
                let validationDay = Calendar.current.component(.weekday, from: value)
                var daysDescriptions: [String] = []

                return days.contains { day in
                    if day.rawValue == validationDay {
                        daysDescriptions.append(day.getDescription())
                        return true
                    }
                    return false
                } ? "Invalid day: \(daysDescriptions.joined(separator: ", "))." : nil
            case .future:
                return value > Date() ? "Date cannot be in the future." : nil
        }
    }
}
