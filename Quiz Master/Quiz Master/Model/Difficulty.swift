//
//  Difficulty.swift
//  Quiz Master
//
//  Created by Izzat Syamil on 20/04/2024.
//

import SwiftData

enum Level: Int, Codable {
    case easy = 1
    case medium = 2
    case hard = 3
}

@Model
final class Difficulty {
    
    var level: Level
    var score: Int?
    var category: Category?
    
    init(level: Level, score: Int? = nil, category: Category? = nil) {
        self.level = level
        self.score = score
        self.category = category
    }
}
