//
//  LeaderboardRow.swift
//  Quiz Master
//
//  Created by Izzat Syamil on 25/04/2024.
//

import SwiftUI

struct LeaderboardRow: View {
    
    var rank: Int
    var attempt: Attempt
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text(attempt.when)
                    .font(.caption2)
                    .foregroundStyle(.gray)
                HStack {
                    ZStack {
                        Text("#\(rank + 1)")
                            .fontWeight(.bold)
                            .foregroundStyle(.indigo)
                    }
                    .padding(7)
                    .background {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(.yellow)
                    }
                    VStack(alignment: .leading) {
                        Text(attempt.difficulty?.category?.name ?? "category_name")
                            .font(.headline)
                        
                        let level = attempt.difficulty?.level.rawValue ?? 0
                        
                        Text("Level \(level)")
                            .font(.subheadline)
                    }
                }
                HStack {
                    HStack {
                        Image(systemName: "timer.circle.fill")
                            .foregroundStyle(.pink)
                        Text("\(attempt.totalTimeTaken)s")
                            .font(.caption)
                    }
                    .padding(.trailing, 8)
                    HStack {
                        Image(systemName: "checkmark.rectangle.stack.fill")
                            .foregroundStyle(.mint)
                        Text("\(attempt.totalCorrectAnswer) / \(QUESTION_COUNT)")
                            .font(.caption)
                    }
                }
                .padding(.top, 4)
            }
            Spacer()
            ZStack {
                Text("\(attempt.score)")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.cyan)
            }
            .padding(.vertical, 2)
            .padding(.horizontal, 20)
        }
    }
}

//extension LeaderboardRow {
//    private func getReadableDate(timestamp: UInt64) -> String {
//        print(timestamp)
//        let date = Date(timeIntervalSince1970: TimeInterval( Double(timestamp)))
//        return date.formatted()
//    }
//}

#Preview {
    do {
        let previewer = try Previewer()
        return LeaderboardRow(
            rank: 1, attempt: previewer.attempt
        )
    } catch {
        return Text("Error")
    }
}
