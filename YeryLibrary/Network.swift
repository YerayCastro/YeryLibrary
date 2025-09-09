//
//  Network.swift
//  YeryLibrary
//
//  Created by Yery Castro on 7/3/24.
//

import Foundation
import SwiftUI

protocol DataInteractor {
    func getBooks() async throws -> [Book]
    func getAuthors() async throws -> [Author]
}

struct Network: DataInteractor {
    let cache = URL.cachesDirectory
    static let shared = Network()
    
    func getJSON<JSON>(request: URLRequest, type: JSON.Type) async throws -> JSON where JSON: Codable {
        let (data, response) = try await URLSession.shared.getData(for: request)
        if response.statusCode == 200 {
            do {
                return try JSONDecoder().decode(type, from: data)
            } catch {
                throw NetworkError.json(error)
            }
        } else {
            throw NetworkError.status(response.statusCode)
        }
    }
    
    func postJSON(request: URLRequest, status: Int = 200) async throws {
        let (_, response) = try await URLSession.shared.getData(for: request)
        if response.statusCode != status {
            throw NetworkError.status(response.statusCode)
        }
    }
    
    func getBooks() async throws -> [Book] {
        try await getJSON(request: .get(url: .getBooks), type: [Book].self)
    }
    
    func getAuthors() async throws -> [Author] {
        try await getJSON(request: .get(url: .getAuthors), type: [Author].self)
    }
}
