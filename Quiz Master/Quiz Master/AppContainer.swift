//
//  AppContainer.swift
//  Quiz Master
//
//  Created by Izzat Syamil on 20/04/2024.
//

import Foundation
import SwiftData

let categoryData = [
    Category(id: 9, name: "General Knowledge"),
    Category(id: 10, name: "Entertainment: Books"),
    Category(id: 11, name: "Entertainment: Film"),
    Category(id: 12, name: "Entertainment: Music"),
    Category(id: 13, name: "Entertainment: Musicals & Theathers"),
    Category(id: 14, name: "Entertainment: Television"),
    Category(id: 15, name: "Entertainment: Video Games"),
    Category(id: 16, name: "Entertainment: Board Games"),
    Category(id: 17, name: "Science & Nature"),
    Category(id: 18, name: "Science: Computers"),
    Category(id: 19, name: "Science: Mathematics"),
    Category(id: 20, name: "Mythology"),
    Category(id: 21, name: "Sports"),
    Category(id: 22, name: "Geography"),
    Category(id: 23, name: "History"),
    Category(id: 24, name: "Politics"),
    Category(id: 25, name: "Art"),
    Category(id: 26, name: "Celebrities"),
    Category(id: 27, name: "Animals")
]

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
