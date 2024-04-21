//
//  CategoryRow.swift
//  Quiz Master
//
//  Created by Izzat Syamil on 20/04/2024.
//

import SwiftUI
import SwiftData

struct CategoryRow: View {
    var category: Category
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(category.name)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(category.difficulties.sorted{ $0.level.rawValue < $1.level.rawValue }) { difficulty in
                        NavigationLink {
                            CategoryDetail(category: category, difficulty: difficulty)
                        } label: {
                            LevelChip(difficulty: difficulty)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        return CategoryRow(category: previewer.categories[0])
    } catch {
        return Text("Fatal error")
    }
}
