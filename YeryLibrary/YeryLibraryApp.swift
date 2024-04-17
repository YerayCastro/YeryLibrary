//
//  YeryLibraryApp.swift
//  YeryLibrary
//
//  Created by Yery Castro on 7/3/24.
//

import SwiftUI
import SwiftData

@main
struct YeryLibraryApp: App {
    @State var vm = YeryVM()
    
    var body: some Scene {
        WindowGroup {
            AppStateView()
                .environment(vm)
                .alert("App Alert",
                       isPresented: $vm.showAlert) {
                    
                } message: {
                    Text(vm.errorMsg)
                }
        }
        .modelContainer(for: BooksData.self) { result in
            guard case .success(let container) = result else { return }
            let _ = container.mainContext
        }
    }
}
