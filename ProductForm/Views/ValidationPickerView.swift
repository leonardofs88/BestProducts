//
//  EvaluationView.swift
//  BestProducts
//
//  Created by Leonardo Soares on 17/10/2025.
//

import SwiftUI

struct ValidationPickerView<E: MenuPickItem>: View {

    var description: String

    @State private(set) var selection: E

    var body: some View {
        HStack {
            Text(description)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(.productBackgroundShadow)
                .padding(.horizontal)
                .padding(.vertical, 10)

            Spacer()

            Picker(description, selection: $selection) {
                ForEach(Evaluation.allCases) { evaluation in
                    Text(evaluation.rawValue.capitalized)
                        .tag(evaluation)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
    }
}

protocol MenuPickItem: Hashable, CaseIterable, Identifiable {}

enum Evaluation: String, MenuPickItem {
    case bad
    case regular
    case good
    case veryGood
    case excelent

    var id: Self { self }
}

#Preview {
    ValidationPickerView(description: "Picker", selection: Evaluation.bad)
}
