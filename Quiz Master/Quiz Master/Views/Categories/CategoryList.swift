//
//  CategoryHome.swift
//  Quiz Master
//
//  Created by Izzat Syamil on 20/04/2024.
//

import SwiftUI
import SwiftData

struct CategoryList: View {
    
    @Query(sort: \Category.name) var categories: [Category]
    
    var body: some View {
        NavigationSplitView {
            List(categories) { category in
                CategoryRow(category: category)
            }
            .navigationTitle("Quiz")
        } detail: {
            Text("Select a category")
        }
    }
}

#Preview {
    do {
        let preview = try Previewer()
        return CategoryList().modelContainer(preview.container)
    } catch {
        return Text("Error")
    }
}
