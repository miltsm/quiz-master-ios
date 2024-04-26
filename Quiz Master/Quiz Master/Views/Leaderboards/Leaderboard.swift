//
//  Leaderboard.swift
//  Quiz Master
//
//  Created by Izzat Syamil on 20/04/2024.
//

import SwiftUI
import SwiftData

struct Leaderboard: View {
    
    @Query(sort: \Attempt.score, order: .reverse) private let attempts: [Attempt]
    
    var body: some View {
        if attempts.isEmpty {
            Text("No entries yet :(")
        } else {
            List(Array(attempts.enumerated()), id: \.1.id) { (index, attempt) in
                LeaderboardRow(rank: index, attempt: attempt)
            }
        }
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        return Leaderboard().modelContainer(previewer.container)
    } catch {
        return Text("Error")
    }
}
