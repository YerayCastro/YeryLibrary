//
//  Splash.swift
//  YeryLibrary
//
//  Created by Yery Castro on 12/3/24.
//

import SwiftUI

struct Splash: View {
    @Environment(YeryVM.self) var vm
    @State var loading = false
    @State var appear = false
    
    var body: some View {
        ZStack {
            Color(.yery)
            Image(.icono)
                .offset(y: appear ? -150 : 0)
            ProgressView()
                .controlSize(.extraLarge)
                .tint(.black)
                .opacity(loading ? 1.0 : 0.0)

        }
        .ignoresSafeArea()
        .animation(.bouncy().speed(0.5), value: appear)
        .task {
            try? await Task.sleep(for: .seconds(1))
            appear = true
            try? await Task.sleep(for: .seconds(2))
            loading = true
            await vm.getData()
            loading = false
            vm.appState = .home
        }
    }
}

#Preview {
    Splash()
        .environment(YeryVM())
}
