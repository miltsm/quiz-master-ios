//
//  Quiz_MasterTests.swift
//  Quiz MasterTests
//
//  Created by Izzat Syamil on 20/04/2024.
//

import XCTest
@testable import Quiz_Master


class QuizMasterTests: XCTestCase {
    func testGeoJSONDecoderDecodesQuiz() throws {
        let decoder = JSONDecoder()
        let quiz = try decoder.decode(Question.self, from: testQuiz_correct_answer_poisson)
        
        XCTAssert(quiz.correctAnswer == "poisson")
    }
    
//    func testGeoJSONDecoderDecodesGeoJSON() throws {
//        let decoder = JSONDecoder()
//        let decoded = try decoder.decode(QuizResponse.self, from: testQuizzesData)
//        
//        XCTAssertEqual(decoded.questions.count, 5)
//    }
//    
//    func testClientDoesFetchQuizQuestions() async throws {
//        let downloader = TestDownloader()
//        let client = QuizClient(downloader: downloader)
//        let quiz = try await client.questions
//        
//        XCTAssertEqual(quiz.count, 5)
//    }
    
    func testScoreLogic() async throws {
        let startTime = DispatchTime.now().uptimeNanoseconds
        try await Task.sleep(nanoseconds: UInt64.random(in: 100_000_000...500_000_000))
        let answerTime = DispatchTime.now().uptimeNanoseconds
        
        let distanceInterval = answerTime - startTime
        let answerInterval = Double(distanceInterval) / 1_000_000_000
        
        let bonusPoint = Int(answerInterval) < 5 ? 50 : 0
        let correctAnswerPoint = 200
        
        let total = bonusPoint + correctAnswerPoint
        
        XCTAssertEqual(total, 400)
    }
}
