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
            HStack {
                Text("min. score to beat:")
                    .foregroundColor(.white)
                    .frame(alignment: .trailing)
                Text("\(SCORE_TO_BEAT * difficulty.level.rawValue)")
                    .foregroundStyle(.pink)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .background {
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .shadow(radius: 25)
            }
            LevelSummaryCard(
                selectedCategory: category,
                selectedDiff: difficulty
            )
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
