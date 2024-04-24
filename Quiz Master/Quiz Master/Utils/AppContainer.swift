//
//  AppContainer.swift
//  Quiz Master
//
//  Created by Izzat Syamil on 20/04/2024.
//

import Foundation
import SwiftData

@MainActor
let appContainer : ModelContainer = {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Category.self, Difficulty.self)
        
        //MARK: Check if categories have been pre-populated
        var categoryFetchDesciptor = FetchDescriptor<Category>()
        categoryFetchDesciptor.fetchLimit = 1
        
        guard try container.mainContext.fetch(categoryFetchDesciptor).count == 0 else { return container }
        
        for category in categoryData {
            container.mainContext.insert(category)
        }
        
        return container
    } catch {
        fatalError("Failed to create container")
    }
}()
