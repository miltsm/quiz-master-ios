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
    var category: Category?
    var highScore: Int? = nil
    var bestTime: Int = 0
    var isUnlocked = false
    var attempts: [Attempt] = []
    
    init(level: Level, category: Category? = nil) {
        self.level = level
        self.category = category
        self.isUnlocked = level.rawValue == 1
    }
}
