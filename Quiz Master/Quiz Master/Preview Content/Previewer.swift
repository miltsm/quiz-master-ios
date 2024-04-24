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
    
    init() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(for: Category.self, Difficulty.self, configurations: config)

        categories = [
            categoryData[0],
            categoryData[1]
        ]
        
        for category in categories {
            container.mainContext.insert(category)
        }
    }
}
