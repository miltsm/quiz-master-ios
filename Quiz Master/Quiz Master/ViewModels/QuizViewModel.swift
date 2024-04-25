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
    
    private var level = 1
    
    @Published var questions: [Question] = []
    @Published var answers: [Answer] = []
    @Published var totalScore: Int = 0
    @Published var progress: Float = 1.0
    @Published var secondsToCompletion = MAX_TIMER_COUNT
    @Published var sessionEnded = false
    @Published var timeTaken = 0
    
    let client: QuizClient
    
    init(client: QuizClient = QuizClient()) {
        self.client = client
    }
}

//MARK: Fetch quiz questions
extension QuizViewModel {
    @MainActor
    func fetchQuiz(categoryId: Int, level: Level) async throws {
        self.level = level.rawValue
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
        let points = ((isCorrect ? CORRECT_PTS : totalScore == 0 ? 0 : INCORRECT_PTS) + bonus) * level //scale by difficulty
        
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
        
        if answers.count == QUESTION_COUNT {
            stopTimer()
        }
    }
    
    func getSessionAttempt() -> Attempt {
        return Attempt(
            score: totalScore,
            when: Date().formatted(),
            totalTimeTaken: timeTaken,
            totalCorrectAnswer: answers.filter({ $0.isCorrect }).count,
            beatsMinScoreThreshold: totalScore > (SCORE_TO_BEAT * level)
        )
    }
}

//MARK: Timer handler
extension QuizViewModel {
    private func startTimer() {
        //retry init
        quizStartTime = DispatchTime.now().uptimeNanoseconds
        
        timer = Timer.scheduledTimer(
            withTimeInterval: 1.0,
            repeats: true,
            block: { [weak self] _ in
                guard let self else { return }
                self.secondsToCompletion -= 1
                self.progress = Float(self.secondsToCompletion) / Float(60.0)
                print("timer -> \(secondsToCompletion) progress -> \(progress)")
                
                if secondsToCompletion < 0 {
                    stopTimer()
                    if !sessionEnded {
                        sessionEnded = true
                    }
                }
            }
        )
    }
    
    private func stopTimer() {
        timer.invalidate()
    }
    
    func calculateTimeTaken() {
//        guard let completeTime = answers.last?.timestamp else {
//            return
//        }
        let diff = MAX_TIMER_COUNT - secondsToCompletion
        self.timeTaken = diff == 0 ? MAX_TIMER_COUNT : diff
        
        
    }
}

//MARK: session clean
extension QuizViewModel {
    func cleanSession() {
        timer.invalidate()
        sessionEnded = false
        answers.removeAll()
        totalScore = 0
        secondsToCompletion = MAX_TIMER_COUNT
        progress = 1
    }
}
