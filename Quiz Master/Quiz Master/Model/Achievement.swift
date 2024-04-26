//
//  Achievement.swift
//  Quiz Master
//
//  Created by Izzat Syamil on 26/04/2024.
//

import Foundation
import SwiftData

enum AchievementType: String, Codable {
    case allCorrectFirstTryEasy = "Answered all questions correctly on the first attempt (Easy)"
    case allCorrectFirstTry = "Answered all questions correctly on the first attempt"
    case allCorrectFirstTryHard = "Answered all questions correctly on the first attempt (Hard)"
    case beatUnderHalfOfTimerTotalEasy = "Answered all questions under half of the provided time (Easy)"
    case beatUnderHalfOfTimerTotal = "Answered all questions under half of the provided time"
    case beatUnderHalfOfTimerTotalHard = "Answered all questions under half of the provided time (Hard)"
}

@Model
class Achievement {
    let type: AchievementType
    let when: String
    @Relationship(deleteRule: .noAction, inverse: \Attempt.achievements)
    let attempt: Attempt? = nil
    
    init(type: AchievementType, when: String) {
        self.type = type
        self.when = when
    }
}
