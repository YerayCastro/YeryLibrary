//
//  StateMachines.swift
//  YeryLibrary
//
//  Created by Yery Castro on 12/3/24.
//

import SwiftUI

enum AppState {
    case splash
    case home
    case noInternet
}

struct ScrollOffset: PreferenceKey {
    typealias Value = CGFloat
    
    static var defaultValue: CGFloat = 0.0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
