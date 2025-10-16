//
//  ViewOffsetKey.swift
//  BestProducts
//
//  Created by Leonardo Soares on 16/10/2025.
//

import SwiftUI

extension View {
    func scrollOffset(namespace: Namespace.ID) -> some View {
        self
            .background(GeometryReader {
                Color.clear.preference(key: ViewOffsetKey.self,
                                       value: $0.frame(in: .named(namespace)))
            })
    }
}
