//
//  StartQuizCard.swift
//  Quiz Master
//
//  Created by Izzat Syamil on 20/04/2024.
//

import SwiftUI
import SwiftData
import Foundation

struct LevelSummaryCard: View {
    @EnvironmentObject var router : Router
    
    private var selectedCategory: Category
    private var selectedDiff: Difficulty
    
//    @Query()
//    private var attempts: [Attempt]
    
    init(selectedCategory: Category, selectedDiff: Difficulty) {
        self.selectedCategory = selectedCategory
        self.selectedDiff = selectedDiff
        
//        _attempts = Query(
//            filter: #Predicate<Attempt> { attempt in
//                if let attemptLvl = attempt.difficulty {
//                    return attemptLvl.level.rawValue == selectedDiff.level.rawValue
//                } else {
//                    return false
//                }
//            },
//            animation: .default
//        )
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Level \(selectedDiff.level.rawValue)").font(.largeTitle)
                Spacer()
                VStack {
                    VStack {
                        Text("Total Score:").font(.caption)
                        Text("\(selectedDiff.highScore ?? 0)").font(.headline)
                    }
                    .padding(.bottom, 10)
                    VStack {
                        Text("Best Time:").font(.caption)
                        Text("\(selectedDiff.bestTime)s").font(.headline)
                    }
                }
            }
            Button(action: {
                router.navigate(
                    to: .session(category: selectedCategory, diff: selectedDiff)
                )
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
        return LevelSummaryCard(
            selectedCategory: previewer.categories[0],
            selectedDiff: previewer.categories[0].difficulties[0]
        )
    } catch {
        return Text("Error")
    }
}
