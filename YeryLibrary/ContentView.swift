//
//  ContentView.swift
//  YeryLibrary
//
//  Created by Yery Castro on 7/3/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(YeryVM.self) var vm
    @Environment(\.modelContext) var context
    @Query var readedBooks: [BooksData]
    @State var selected: Book?
    @Namespace private var namespace
    
    let item = GridItem(.adaptive(minimum: 150), alignment: .center)
    
    var body: some View {
        ZStack {
            mainScroll
                .opacity(selected == nil ? 1.0 : 0.0)
            if selected != nil {
                BookDetail(selected: $selected, namespace: namespace)
            }
        }
        .animation(.default, value: selected)
    }
    
    var mainScroll: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [item]) {
                    ForEach(vm.books.books) { book in
                        Group {
                            if book != selected {
                                BookCover(book: book, namespace: namespace)
                                    .onTapGesture {
                                        selected = book
                                    }
                                    .contextMenu {
                                        Button {
                                            try? vm.toggleReaded(book: book, context: context)
                                        } label: {
                                            if readedBooks.contains(where: { $0.id == book.id }) {
                                                Label("Mark as unread", systemImage: "book.fill")
                                            } else {
                                                Label("Mark as read", systemImage: "book")
                                            }
                                        }
                                    }
                                    .padding()
                            } else {
                                Rectangle()
                                    .fill(.clear)
                                    .frame(width: 150, height: 230)
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Yery Books")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        vm.login = true
                    } label: {
                        Image(systemName: "person.circle.fill")
                            .font(.title)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView.preview
        .modelContainer(testModelContainer)
}
