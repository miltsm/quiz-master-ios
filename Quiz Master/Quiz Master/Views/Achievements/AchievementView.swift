//
//  AchievementView.swift
//  Quiz Master
//
//  Created by Izzat Syamil on 26/04/2024.
//

import SwiftUI
import SwiftData

struct AchievementView: View {
    
    @Query private let achievements: [Achievement]
    
    var body: some View {
        if achievements.isEmpty {
            Text(":(")
        } else {
            List(achievements) { achievement in
                AchievementBadge(achievement: achievement)
            }
        }
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        return AchievementView().modelContainer(previewer.container)
    } catch {
        return Text("Error")
    }
}
