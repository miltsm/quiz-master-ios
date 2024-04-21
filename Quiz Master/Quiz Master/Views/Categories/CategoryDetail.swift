//
//  LevelView.swift
//  Quiz Master
//
//  Created by Izzat Syamil on 20/04/2024.
//

import SwiftUI
import SwiftData

struct CategoryDetail : View {
    
    var category: Category
    var difficulty: Difficulty
    
    var body: some View {
        VStack {
            Spacer()
            LevelSummaryCard(category: category, difficulty: difficulty)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 30)
        .background(.yellow)
        .navigationTitle(category.name)
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        return CategoryDetail(category: previewer.categories[0], difficulty: previewer.categories[0].difficulties[0])
    } catch {
        return Text("Error")
    }
}
