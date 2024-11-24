//
//  BooksViewModel.swift
//  BooksApp
//
//  Created by Imrul Kayes on 24/11/24.
//
import Foundation
import Combine
import SwiftData

class BooksViewModel: ObservableObject {
    @Published var books: [Book] = []
    private var context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    @MainActor
    func loadBooks() async {
        do {
            let descriptor = FetchDescriptor<Book>(sortBy: [SortDescriptor(\.title)])
            books = try context.fetch(descriptor)
            
            // If no books in local storage, try fetching from network
            if books.isEmpty {
                try await fetchAndStoreBooks()
                books = try context.fetch(descriptor)
            }
        } catch {
            print("Error loading books: \(error)")
        }
    }
    
    @MainActor
    private func fetchAndStoreBooks() async throws {
        // Fetch from network
        let books = try await NetworkManager.shared.fetchBooks()
        
        // Store in SwiftData
        for book in books {
            context.insert(book)
        }
        
        try context.save()
    }
    
    @MainActor
    func refreshBooks() async {
        do {
            try await fetchAndStoreBooks()
            let descriptor = FetchDescriptor<Book>(sortBy: [SortDescriptor(\.title)])
            books = try context.fetch(descriptor)
        } catch {
            print("Error refreshing books: \(error)")
        }
    }
}

