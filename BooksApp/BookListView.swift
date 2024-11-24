//
//  BookListView.swift
//  BooksApp
//
//  Created by Imrul Kayes on 24/11/24.
//

import SwiftUI
import SwiftData
import Combine

struct BookListView: View {
    @Environment(\.modelContext) private var context
    @StateObject private var viewModel: BooksViewModel
    
    init(context: ModelContext) {
        _viewModel = StateObject(wrappedValue: BooksViewModel(context: context))
    }
    
    var body: some View {
        NavigationView {
            List(viewModel.books, id: \.id) { book in
                VStack(alignment: .leading) {
                    Text(book.title)
                        .font(.headline)
                    Text(book.author)
                        .font(.subheadline)
                    Text("Year: \(book.year ?? 0)")
                        .font(.caption)
                }
            }
            .navigationTitle("Books")
            .toolbar {
                Button("Refresh") {
                    Task {
                        await viewModel.refreshBooks()
                    }
                }
            }
        }
        .task {
            await viewModel.loadBooks()
        }
    }
}

