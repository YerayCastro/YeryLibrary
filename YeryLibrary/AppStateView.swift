//
//  AppState.swift
//  YeryLibrary
//
//  Created by Yery Castro on 12/3/24.
//

import SwiftUI

        
    struct AppStateView: View {
        @Environment(YeryVM.self) var vm
        @State var networkStatus = NetworkStatus()
        @State var lastState: AppState = .splash
        
        var body: some View {
            Group {
                switch vm.appState {
                case .splash:
                    Splash()
                case .home:
                    YeryMain()
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                case .noInternet:
                    NoConnectionView()
                        .transition(.opacity)
                }
            }
            .animation(.easeIn, value: vm.appState)
            .onChange(of: networkStatus.status) {
                if networkStatus.status == .offline {
                    lastState = vm.appState
                    vm.appState = .noInternet
                } else {
                    vm.appState = lastState
                }
            }
        }
    }

#Preview {
    AppStateView()
        .environment(YeryVM())
}
