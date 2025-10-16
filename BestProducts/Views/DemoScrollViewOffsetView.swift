//
//  DemoScrollViewOffsetView.swift
//  BestProducts
//
//  Created by Leonardo Soares on 16/10/2025.
//

import SwiftUI

extension View {
    func scrollOffset(namespace: Namespace.ID) -> some View {
        modifier(ScrollOffsetModifier(namespace: namespace))
    }
}

struct ScrollOffsetModifier: ViewModifier {
    private(set) var namespace: Namespace.ID

    func body(content: Content) -> some View {
        content
            .background(GeometryReader {
                Color.clear.preference(key: ViewOffsetKey.self,
                                       value: -$0.frame(in: .named(namespace)).origin)
            })
    }
}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGPoint
    static var defaultValue = CGPoint.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}
