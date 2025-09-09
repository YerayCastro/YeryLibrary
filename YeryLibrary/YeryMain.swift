//
//  YeryMain.swift
//  YeryLibrary
//
//  Created by Yery Castro on 7/3/24.
//

import SwiftUI

struct YeryMain: View {
    @Environment(YeryVM.self) var vm
    var body: some View {
        @Bindable var bvm = vm
        TabView {
            ContentView()
                .tabItem {
                    Label("Books", systemImage: "books.vertical")
                }
            ReadedBooks()
                .tabItem {
                    Label("Readed", systemImage: "book.closed")
                }
        }
        .loginView(login: $bvm.login)
    }
}

#Preview {
    YeryMain.preview
}
