//
//  QuizProvider.swift
//  Quiz Master
//
//  Created by Izzat Syamil on 21/04/2024.
//

import Foundation

class QuizViewModel: ObservableObject {
    
    let startTime: UInt64
    
    @Published var questions: [Question] = []
    @Published var answers: [Answer] = []
    
    let client: QuizClient
    
    init(client: QuizClient = QuizClient()) {
        self.client = client
        self.startTime = DispatchTime.now().uptimeNanoseconds
    }
}

//MARK: Fetch quiz questions
extension QuizViewModel {
    @MainActor
    func fetchQuiz(categoryId: Int, level: Level) async throws {
        let fetched = try await client.getQuiz(categoryId: categoryId, level: level)
        self.questions = fetched
    }
}

//MARK: Attempts keeping
extension QuizViewModel {
    func submitAnswer(questionId: String, choice: Choice) {
        let question = questions.first(where: { $0.id == questionId })
        let isCorrect = question?.correctAnswer == choice.answer
        answers.append(
            Answer(
                questionId: questionId,
                isCorrect: isCorrect,
                score: isCorrect ? 1 : 0,
                correctAnswer: question?.correctAnswer ?? "",
                isQuickAndCorrectAnswer: false,
                timestamp: DispatchTime.now().uptimeNanoseconds
            )
        )
        print(answers)
    }
}
