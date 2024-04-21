//
//  Category.swift
//  Quiz Master
//
//  Created by Izzat Syamil on 20/04/2024.
//

import SwiftData

@Model
final class Category {
    var id: Int
    var name: String
    @Relationship(deleteRule: .cascade, inverse: \Difficulty.category)
    var difficulties = [Difficulty]()
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
        difficulties =  [
            Difficulty(level: .easy),
            Difficulty(level: .medium),
            Difficulty(level: .hard)
        ]
    }
}
