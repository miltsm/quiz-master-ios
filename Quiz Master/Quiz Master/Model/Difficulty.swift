//
//  Difficulty.swift
//  Quiz Master
//
//  Created by Izzat Syamil on 20/04/2024.
//

import SwiftData

@Model
final class Difficulty {
    var level: Int
    var score: Int?
    var category: Category?
    
    init(level: Int, score: Int? = nil, category: Category? = nil) {
        self.level = level
        self.score = score
        self.category = category
    }
}
