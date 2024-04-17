//
//  ReadedBooks.swift
//  YeryLibrary
//
//  Created by Yery Castro on 7/3/24.
//

import SwiftUI
import SwiftData

struct ReadedBooks: View {
    @Environment(\.modelContext) var context
    @Query(sort: \BooksData.title, animation: .default) var readedBooks: [BooksData]
    
    var body: some View {
        List {
            ForEach(readedBooks) { book in
                VStack(alignment: .leading) {
                    Text(book.title)
                        .font(.headline)
                    Text(book.author?.name ?? "")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .swipeActions {
                    Button(role: .destructive) {
                        deleteReaded(book: book)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                    .tint(.red)
                }
            }
        }
    }
    
    func deleteReaded(book: BooksData) {
        context.delete(book)
    }
}

#Preview {
    ReadedBooks()
        .modelContainer(testModelContainer)
}
