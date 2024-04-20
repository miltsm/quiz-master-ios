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
    
    enum Tab {
        case categories
        case leaderboard
    }
    
    var body: some View {
        TabView(selection: $selection) {
            CategoryList().tabItem { Label("Quiz", systemImage: "checklist") }.tag(Tab.categories)
            Leaderboard().tabItem { Label("Leaderboard", systemImage: "trophy") }.tag(Tab.leaderboard)
        }
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
