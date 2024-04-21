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
    
    func testGeoJSONDecoderDecodesGeoJSON() throws {
        let decoder = JSONDecoder()
        let decoded = try decoder.decode(QuizResponse.self, from: testQuizzesData)
        
        XCTAssertEqual(decoded.questions.count, 5)
    }
    
    func testClientDoesFetchQuizQuestions() async throws {
        let downloader = TestDownloader()
        let client = QuizClient(downloader: downloader)
        let quiz = try await client.questions
        
        XCTAssertEqual(quiz.count, 5)
    }
}
