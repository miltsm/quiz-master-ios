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
    
    enum Tab {
        case categories
        case leaderboard
    }
    
    var body: some View {
        NavigationStack(path: $router.path) {
            TabView(selection: $selection) {
                CategoryList().tabItem { Label("Quiz", systemImage: "checklist") }.tag(Tab.categories)
                Leaderboard().tabItem { Label("Leaderboard", systemImage: "trophy") }.tag(Tab.leaderboard)
            }.navigationDestination(for: Router.Destination.self) { destination in
                
                switch destination {
                case .session(let category, let level):
                    QuizView(
                        selectedCategory: category,
                        level: level
                    ).environmentObject(quizVM)
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
