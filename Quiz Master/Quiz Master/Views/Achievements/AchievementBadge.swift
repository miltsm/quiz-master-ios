//
//  AchievementRow.swift
//  Quiz Master
//
//  Created by Izzat Syamil on 26/04/2024.
//

import SwiftUI

struct AchievementBadge: View {
    
    var achievement: Achievement
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .fill(.orange)
                Text("Nice")
                    .foregroundStyle(.white)
            }
            .padding(3)
            .frame(width: 80)
            .background {
                Circle()
                    .fill(.mint)
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            }
            VStack(alignment: .leading) {
                Text("\(achievement.type.rawValue)")
                Text("\(achievement.when)")
                    .font(.caption2)
                    .foregroundStyle(.gray)
            }
        }
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        return AchievementBadge(
            achievement: previewer.achievement
        )
    } catch {
        return Text("Error")
    }
}
