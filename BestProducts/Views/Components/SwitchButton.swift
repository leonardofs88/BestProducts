//
//  SwitchButton.swift
//  BestProducts
//
//  Created by Leonardo Soares on 15/10/2025.
//

import SwiftUI

struct SwitchButton: View {

    @State private(set) var isPressed: Bool = false

    private(set) var buttonType: AppSysteButtomType
    private(set) var action: (Bool) -> Void

    var body: some View {
        Button {
            isPressed.toggle()
            action(isPressed)
        } label: {
            switch buttonType {
            case .image(let imageName):
                Image(systemName: imageName)
            case .text(let text):
                Text(text)
                        .fontWeight(.semibold)
            }
        }
        .padding(.horizontal, 10)
        .frame(height: 45)
        .fontWeight(.semibold)
        .foregroundStyle(.productBackgroundShadow)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.productBackground.opacity(isPressed ? 0.8 : 1))
                .shadow(
                    color: .productBackgroundShadow,
                    radius: 0,
                    y: isPressed ? 1 : 3
                )
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .fill(.clear)
                .stroke(.productBackgroundShadow.opacity(isPressed ? 0.8 : 1), lineWidth: 1)
        )
        .scaleEffect(isPressed ? 0.98 : 1)
    }
}

#Preview {
    SwitchButton(
        buttonType: .image("chevron.right")
    ) { isPressed in
        print(
            isPressed
        )
    }

    SwitchButton(
        buttonType: .text("There are some text here")
    ) { isPressed in
        print(
            isPressed
        )
    }
}

enum AppSysteButtomType {
    case image(String)
    case text(String)
}
