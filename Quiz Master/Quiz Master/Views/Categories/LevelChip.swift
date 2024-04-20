//
//  LevelColumn.swift
//  Quiz Master
//
//  Created by Izzat Syamil on 20/04/2024.
//

import SwiftUI

struct LevelChip: View {
    var difficulty: Difficulty
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Level \(difficulty.level)")
            HStack(alignment: .firstTextBaseline) {
                Text("Score: \(difficulty.score ?? 0)").font(.caption)
            }
        }
        .frame(width: 140, height: 60)
        .background(.yellow)
        .cornerRadius(5)
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        return LevelChip(
            difficulty: previewer.categories[0].difficulties[0]
        ).modelContainer(previewer.container)
    } catch {
        return Text("Error")
    }
}
