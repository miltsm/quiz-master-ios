//
//  ContentView.swift
//  Quiz Master
//
//  Created by Izzat Syamil on 20/04/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @State private var selection: Tab = .categories
    
    @ObservedObject private var router = Router()
    
    @StateObject var quizVM = QuizViewModel()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            TabView(selection: $selection) {
                CategoryList().tabItem { Label("Quiz", systemImage: "checklist") }.tag(Tab.categories)
                
                Leaderboard().tabItem {
                    Label(
                        "Leaderboard",
                        systemImage: "arrow.up.arrow.down.square.fill")
                }.tag(Tab.leaderboard)
                
                AchievementView().tabItem {
                    Label("Achievement", systemImage: "trophy")
                }.tag(Tab.achievement)
            }.navigationDestination(for: Router.Destination.self) { destination in
                switch destination {
                case .session(let category, let diff):
                    QuizView(
                        selectedCategory: category,
                        difficulty: diff
                    )
                    .environmentObject(quizVM)
                    .environmentObject(router)
                case .result(let category, let diff):
                    ResultView(
                        selectedCategory: category,
                        difficulty: diff
                    )
                    .environmentObject(quizVM)
                    .environmentObject(router)
                }
            }
        }
        .environmentObject(router)
    }
}

#Preview {
    do {
        let preview = try Previewer()
        return ContentView().modelContainer(preview.container)
    } catch {
        return Text("Error")
    }
}
