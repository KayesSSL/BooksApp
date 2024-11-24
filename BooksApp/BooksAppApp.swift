//
//  BooksAppApp.swift
//  BooksApp
//
//  Created by Imrul Kayes on 24/11/24.
//

import SwiftUI
import SwiftData

@main
struct BooksAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Book.self)
        }
    }
}
