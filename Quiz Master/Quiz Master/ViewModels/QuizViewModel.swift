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
    private var timer = Timer()
    
    @Published var questions: [Question] = []
    @Published var answers: [Answer] = []
    @Published var totalScore: Int = 0
    @Published var progress: Float = 1.0
    @Published var secondsToCompletion = MAX_TIMER_COUNT
    
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
        startTimer()
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
        
        let bonus = Int(answerInterval) < 5 && isCorrect ? BONUS_PTS : 0
        let points = (isCorrect ? CORRECT_PTS : totalScore == 0 ? 0 : INCORRECT_PTS) + bonus
        
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

//MARK: Timer handler
extension QuizViewModel {
    private func startTimer() {
        quizStartTime = DispatchTime.now().uptimeNanoseconds
        timer = Timer.scheduledTimer(
            withTimeInterval: 1.0,
            repeats: true,
            block: { [weak self] _ in
                guard let self else { return }
                self.secondsToCompletion -= 1
                self.progress = Float(self.secondsToCompletion) / Float(60.0)
                print("timer -> \(secondsToCompletion) progress -> \(progress)")
                
                if (secondsToCompletion < 0) {
                    timer.invalidate()
                    secondsToCompletion = 0
                    progress = 0
                }
            }
        )
    }
}
