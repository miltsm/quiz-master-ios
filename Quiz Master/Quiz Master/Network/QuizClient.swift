//
//  QuizClient.swift
//  Quiz Master
//
//  Created by Izzat Syamil on 21/04/2024.
//

import Foundation

class QuizClient {
    
    private lazy var decoder: JSONDecoder = {
       let aDecoder = JSONDecoder()
        return aDecoder
    }()
    
    func getQuiz(categoryId: Int, level: Level) async throws -> [Question] {
        let url = URL(string: "https://opentdb.com/api.php?amount=\(QUESTION_COUNT)&type=multiple&category=\(categoryId)&difficulty=\(level.self)")!
        let data = try await downloader.httpData(from: url)
        let respond = try decoder.decode(QuizResponse.self, from: data)
        print(url)
        print(respond)
        return respond.questions
    }
    
    private let downloader: any HttpDataDownloader
    
    init(downloader: any HttpDataDownloader = URLSession.shared) {
        self.downloader = downloader
    }
}
