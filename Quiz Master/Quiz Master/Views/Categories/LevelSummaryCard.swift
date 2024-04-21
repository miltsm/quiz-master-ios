//
//  StartQuizCard.swift
//  Quiz Master
//
//  Created by Izzat Syamil on 20/04/2024.
//

import SwiftUI

struct LevelSummaryCard: View {
    @EnvironmentObject var router : Router
    
    var category: Category
    var difficulty: Difficulty
    
    var body: some View {
        VStack {
            HStack {
                Text("Level \(difficulty.level.rawValue)").font(.largeTitle)
                Spacer()
                VStack {
                    VStack {
                        Text("Total Score:").font(.caption)
                        Text("\(difficulty.score ?? 0)").font(.headline)
                    }
                    .padding(.bottom, 10)
                    VStack {
                        Text("Best Time:").font(.caption)
                        Text("00:00").font(.headline)
                    }
                }
            }
//            NavigationLink(destination: SessionView()){
//                Label("BEGIN", systemImage: "rectangle.stack.badge.play.fill")
//            }
            Button(action: {
                router.navigate(to: .session(category: category, level: difficulty.level))
            }) {
                Text("Begin").frame(maxWidth: .infinity).font(.title2)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(.all, 20)
        .cornerRadius(10)
        .background(content: {
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
            .cornerRadius(10)
            .shadow(radius: 10)
        })
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        return LevelSummaryCard(category: previewer.categories[0], difficulty: previewer.categories[0].difficulties[0])
    } catch {
        return Text("Error")
    }
}
