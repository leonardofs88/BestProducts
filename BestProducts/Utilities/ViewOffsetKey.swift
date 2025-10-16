//
//  ViewOffsetKey.swift
//  BestProducts
//
//  Created by Leonardo Soares on 16/10/2025.
//

import SwiftUI

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGRect
    static var defaultValue = CGRect.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}
