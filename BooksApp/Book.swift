//
//  Book.swift
//  BooksApp
//
//  Created by Imrul Kayes on 24/11/24.
//

import Foundation
import SwiftData

// MARK: - Models
@Model
final class Book: Codable, CustomStringConvertible {
    enum CodingKeys: String, CodingKey {
        case id, title, author
        case year = "publication_year"
    }
    
    @Attribute(.unique) var id: Int
    var title: String
    var author: String
    var year: Int?
    
    var description: String {
        return "Title: \(title), Author: \(author), Year: \(year ?? 1971)"
    }
    
    init(id: Int, title: String, author: String, year: Int) {
        self.id = id
        self.title = title
        self.author = author
        self.year = year
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.author = try container.decode(String.self, forKey: .author)
        
        // Handle both Int and String for publication_year
        if let yearInt = try? container.decode(Int.self, forKey: .year) {
            year = yearInt
        } else if let yearString = try? container.decode(String.self, forKey: .year),
                  let yearIntFromString = Int(yearString) {
            year = yearIntFromString
        } else {
            // If neither works, set year to nil instead of throwing an error
            year = nil
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(author, forKey: .author)
        try container.encode(year, forKey: .year)
    }
}




