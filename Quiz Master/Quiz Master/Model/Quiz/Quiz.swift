//
//  Quiz.swift
//  Quiz Master
//
//  Created by Izzat Syamil on 21/04/2024.
//

import Foundation

struct Choice: Hashable, Identifiable {
    let id : Int
    let answer: String
}

struct Question: Identifiable {
    let question: String
    let correctAnswer: String
    let incorrects: [String]
    let choices: [Choice]
}

extension Question {
    var id: String { question }
}

extension Question: Decodable {
    private enum CodingKeys: String, CodingKey {
        case question = "question"
        case correctAnswer = "correct_answer"
        case incorrects = "incorrect_answers"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let rawQuestion = try? values.decode(String.self, forKey: .question)
        let rawCorrectAnswer = try? values.decode(String.self, forKey: .correctAnswer)
        let rawIncorrectAnswers = try? values.decode(Array<String>.self, forKey: .incorrects)
        
        guard let question = rawQuestion,
              let correctAnswer = rawCorrectAnswer,
              let incorrects = rawIncorrectAnswers
        else {
            throw QuizError.missingData
        }
        
        self.question = question
        self.correctAnswer = correctAnswer
        self.incorrects = incorrects
        
        //map correct answer + incorrects
        var temp = self.incorrects.enumerated().map { (index, incorrect) in
            Choice(id: index, answer: incorrect)
        }
        
        temp.append(Choice(id: 3, answer: self.correctAnswer))
        
        self.choices = temp.shuffled()
    }
}
