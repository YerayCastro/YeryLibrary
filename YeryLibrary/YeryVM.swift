//
//  YeryVM.swift
//  YeryLibrary
//
//  Created by Yery Castro on 7/3/24.
//

import SwiftUI
import SwiftData

@Observable
final class YeryVM {
    let interactor: DataInteractor
    
    let authors = AuthorsLogic()
    let books = BooksLogic()
    
    var showAlert = false
    var errorMsg = ""
    var appState: AppState = .splash
    var login = false
    
    init(interactor: DataInteractor = Network.shared) {
        self.interactor = interactor
    }
    
    func getData() async {
        do {
            let (books, authors) = try await (interactor.getBooks(), interactor.getAuthors())
            await MainActor.run {
                self.books.books = books
                self.authors.authors = authors
            }
        } catch {
            await MainActor.run {
                self.errorMsg = "\(error)"
                self.showAlert.toggle()
            }
        }
    }
    
    func toggleReaded(book: Book, context: ModelContext) throws {
        guard let name = authors.getAuthor(id: book.author) else { return }
        
        var query = FetchDescriptor<BooksData>()
        let bookID = book.id
        query.predicate = #Predicate { $0.id == bookID }
        if let bookFound = try context.fetch(query).first {
            context.delete(bookFound)
        } else {
            var queryAuthor = FetchDescriptor<AuthorData>()
            let authorID = book.author
            queryAuthor.predicate = #Predicate { $0.id == authorID }
            if let authorFound = try context.fetch(queryAuthor).first {
                let bookDB = BooksData(book: book)
                bookDB.author = authorFound
                context.insert(bookDB)
            } else {
                let authorDB = AuthorData(id: book.author, name: name)
                let bookDB = BooksData(book: book, author: authorDB)
                context.insert(bookDB)
            }
        }
    }
    
    func isBookReaded(book: Book, context: ModelContext) -> Bool {
        var query = FetchDescriptor<BooksData>()
        let bookID = book.id
        query.predicate = #Predicate { $0.id == bookID }
        return (try? context.fetchCount(query)) ?? 0 > 0
    }
}
