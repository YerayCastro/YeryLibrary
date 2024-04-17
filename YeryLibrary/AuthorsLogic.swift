//
//  AuthorsLogic.swift
//  YeryLibrary
//
//  Created by Yery Castro on 7/3/24.
//

import SwiftUI

@Observable
final class AuthorsLogic {
    var authors: [Author] = []
    
    func getAuthor(id: UUID) -> String? {
        authors.first(where: { $0.id == id })?.name
    }
}
