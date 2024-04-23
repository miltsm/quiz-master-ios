//
//  QuizProvider.swift
//  Quiz Master
//
//  Created by Izzat Syamil on 21/04/2024.
//

import Foundation

class QuizViewModel: ObservableObject {
    
    private let BONUS_PTS : Int = 50
    private let CORRECT_PTS : Int = 200
    private let INCORRECT_PTS : Int = -20
    
    private var quizStartTime: UInt64 = 0
    
    @Published var questions: [Question] = []
    @Published var answers: [Answer] = []
    @Published var totalScore: Int = 0
    
    let client: QuizClient
    
    init(client: QuizClient = QuizClient()) {
        self.client = client
    }
}

//MARK: Fetch quiz questions
extension QuizViewModel {
    @MainActor
    func fetchQuiz(categoryId: Int, level: Level) async throws {
        let fetched = try await client.getQuiz(categoryId: categoryId, level: level)
        self.questions = fetched
        quizStartTime = DispatchTime.now().uptimeNanoseconds
    }
}

//MARK: Attempts keeping
extension QuizViewModel {
    func submitAnswer(questionId: String, choice: Choice) {
        let question = questions.first(where: { $0.id == questionId })!
        let isCorrect = question.correctAnswer == choice.answer
        let submitTime = DispatchTime.now().uptimeNanoseconds
        
        let beginTime = (answers.isEmpty ? quizStartTime : answers.last?.timestamp) ?? 0
        let answerInterval = Double(submitTime - beginTime) / 1_000_000_000
        
        let bonus = Int(answerInterval) < 5 ? BONUS_PTS : 0
        let points = (isCorrect ? CORRECT_PTS : INCORRECT_PTS) + bonus
        
        answers.append(
            Answer(
                questionId: questionId,
                isCorrect: isCorrect,
                score: points,
                correctAnswer: question.correctAnswer,
                timestamp: submitTime
            )
        )
      
        totalScore += points
    }
}
