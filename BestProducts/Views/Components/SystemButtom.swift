//
//  SystemButtom.swift
//  BestProducts
//
//  Created by Leonardo Soares on 16/10/2025.
//

import SwiftUI

struct SystemButtom: View {

    @State private var tapped: Bool = false

    private(set) var buttonType: AppSysteButtomType
    private(set) var isDisabled: Bool
    private(set) var action: () -> Void

    init(
        buttonType: AppSysteButtomType,
        isDisabled: Bool = false,
        action: @escaping () -> Void
    ) {
        self.buttonType = buttonType
        self.isDisabled = isDisabled
        self.action = action
    }

    var body: some View {
        Button {
            tapped.toggle()
            withAnimation {
                tapped.toggle()
                action()
            }
        } label: {
            switch buttonType {
            case .image(let imageName):
                Image(systemName: imageName)
                        .padding()
            case .text(let text):
                Text(text)
                        .fontWeight(.semibold)
                        .padding()
            }
        }
        .opacity(isDisabled ? 0.3 : 1)
        .disabled(isDisabled)
        .frame(height: 45)
        .foregroundStyle(.productBackgroundShadow)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.productBackground)
                .shadow(
                    color: Color.productBackgroundShadow,
                    radius: 0,
                    y: tapped ? 1 : 3
                )
                .opacity(isDisabled ? 0.3 : 1)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .fill(.clear)
                .stroke(.productBackgroundShadow, lineWidth: 1)
                .opacity(isDisabled ? 0.3 : 1)
        )
        .scaleEffect(tapped ? 0.98 : 1)
    }
}

#Preview {
    SystemButtom(buttonType: .image("plus")) {
        print("plus button pressed")
    }

    SystemButtom(buttonType: .image("plus"), isDisabled: true) {
        print("plus button pressed")
    }
}
