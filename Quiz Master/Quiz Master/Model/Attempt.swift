//
//  Attempt.swift
//  Quiz Master
//
//  Created by Izzat Syamil on 25/04/2024.
//

import SwiftData

@Model
class Attempt {
    let score: Int
    let when: String
    let totalTimeTaken: Int
    let totalCorrectAnswer: Int
    let beatsMinScoreThreshold = false
    @Relationship(deleteRule: .nullify, inverse: \Difficulty.attempts)
    var difficulty: Difficulty? = nil
    
    init(
        score: Int,
        when: String,
        totalTimeTaken: Int,
        totalCorrectAnswer: Int,
        beatsMinScoreThreshold: Bool
    ) {
        self.score = score
        self.when = when
        self.totalTimeTaken = totalTimeTaken
        self.totalCorrectAnswer = totalCorrectAnswer
        self.beatsMinScoreThreshold = beatsMinScoreThreshold
    }
 
    //static func predicate(
    //    categoryId: Int,
    //    level: Int
    //) -> Predicate<Attempt> {
    //    return #Predicate<Attempt> { attempt in
    //        attempt.difficulty?.category.id == categoryId
    //        &&
    //        attempt.difficulty?.level == level
    //    }
    //}
}
