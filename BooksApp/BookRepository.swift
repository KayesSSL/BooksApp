//
//  BookRepository.swift
//  BooksApp
//
//  Created by Imrul Kayes on 24/11/24.
//

import SwiftData

// MARK: - Repository Pattern
class BookRepository {
    static let shared = BookRepository()
    
    @MainActor
    func fetchAndStoreBooks(context: ModelContext) async {
        do {
            // Fetch from network
            let books = try await NetworkManager.shared.fetchBooks()
            
            // Store in SwiftData
            for book in books {
                context.insert(book)
            }
            
            try context.save()
        } catch {
            print("Error fetching/storing books: \(error)")
        }
    }
}
