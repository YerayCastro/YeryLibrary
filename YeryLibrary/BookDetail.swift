//
//  BookDetail.swift
//  YeryLibrary
//
//  Created by Yery Castro on 11/3/24.
//

import SwiftUI

struct BookDetail: View {
    @Environment(YeryVM.self) private var vm
    @Binding var selected: Book?
    @State private var loaded = false
    private var book: Book!
    let namespace: Namespace.ID
    
    
    init(selected: Binding<Book?>, namespace: Namespace.ID) {
        _selected = selected
        self.namespace = namespace
        if let book = selected.wrappedValue {
            self.book = book
        } 
    }
    
    var body: some View {
        if let book = selected {
            ZStack(alignment: .topTrailing) {
                ScrollView {
                    LazyVStack {
                        BookCover(book: book, big: true, namespace: namespace)
                            .overlay {
                                GeometryReader { proxy in
                                    Color.clear
                                        .preference(key: ScrollOffset.self,
                                                    value: proxy.frame(in: .global).minY)
                                }
                            }
                            .onPreferenceChange(ScrollOffset.self) { value in
                                if value > 250 {
                                    selected = nil
                                }
                            }
                        VStack(alignment: .leading){
                            DetailCell(title: "Title", label: book.title)
                            if let author = vm.authors.getAuthor(id: book.author) {
                                DetailCell(title: "Author", label: author)
                            }
                            DetailCell(title: "Year", label: "\(book.year)")
                            DetailCell(title: "Plot", label: book.plot ?? "")
                            DetailCell(title: "Summary", label: book.summary ?? "")
                            if book.price > 0 {
                                DetailCell(title: "Price", label: "\(book.price.formatted(.currency(code: "eur")))")
                            }
                            DetailCell(title: "Pages", label: "\(book.pages ?? 0)")
                            DetailCell(title: "Rating", label: "\(book.rating ?? 0)")
                            DetailCell(title: "ISBN", label: book.isbn ?? "No tiene")
                        }
                    }
                    .padding()
                }
                
                Button {
                    selected = nil
                } label: {
                    Image(systemName: "xmark")
                        .symbolVariant(.circle)
                        .symbolVariant(.fill)
                        .font(.largeTitle)
                }
                .padding(.trailing)
                .buttonStyle(.plain)
                .opacity(0.5)
                .offset(x: !loaded ? 100 : selected != nil ? 0 : 100)
            }
            .animation(.default, value: loaded)
            .onAppear {
                loaded = true
            }
        }
    }
}

#Preview {
    BookDetail(selected: .constant(.test), namespace: Namespace().wrappedValue)
        .environment(YeryVM.preview)
}

