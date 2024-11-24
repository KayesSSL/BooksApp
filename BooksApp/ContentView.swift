//
//  ContentView.swift
//  BooksApp
//
//  Created by Imrul Kayes on 24/11/24.
//

import SwiftUI
import Combine
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
        
    var body: some View {
        BookListView(context: context)
    }
}

#Preview {
    ContentView()
}
