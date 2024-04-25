//
//  Previewer.swift
//  Quiz Master
//
//  Created by Izzat Syamil on 20/04/2024.
//

import Foundation
import SwiftData

@MainActor
struct Previewer {
    let container: ModelContainer
    let categories: [Category]
    let attempt: Attempt
    
    init() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(for: Category.self, Difficulty.self, configurations: config)

        categories = [
            categoryData.last ?? Category(id: 27, name: "Animals")
        ]
        
        for category in categories {
            container.mainContext.insert(category)
        }
        
        let attempt = Attempt(
            score: 100,
            when: "now",
            totalTimeTaken: 30,
            totalCorrectAnswer: 1,
            beatsMinScoreThreshold: false)
        
        self.attempt = attempt
        
        container.mainContext.insert(attempt)
    }
}
