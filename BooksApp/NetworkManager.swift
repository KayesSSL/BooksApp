//
//  NetworkManager.swift
//  BooksApp
//
//  Created by Imrul Kayes on 24/11/24.
//
import Foundation

// MARK: - Networking
enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://freetestapi.com/api/v1"
    
    func fetchBooks() async throws -> [Book] {
        guard let url = URL(string: "\(baseURL)/books") else {
            throw NetworkError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let books = try JSONDecoder().decode([Book].self, from: data)
        return books
    }
}
