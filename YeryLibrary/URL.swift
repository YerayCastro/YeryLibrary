//
//  URL.swift
//  YeryLibrary
//
//  Created by Yery Castro on 7/3/24.
//

import Foundation

let api = URL(string: "https://trantorapi-acacademy.herokuapp.com/api/")!

extension URL {
    static let getBooks = api.appending(path: "books/list")
    static let getAuthors = api.appending(path: "books/authors")
}
