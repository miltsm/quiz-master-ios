//
//  Quiz.swift
//  Quiz Master
//
//  Created by Izzat Syamil on 21/04/2024.
//

import Foundation

struct QuizResponse: Identifiable {
    let responseCode: Int
    let questions: [Question]
}

extension QuizResponse {
    var id: Int { responseCode }
}

extension QuizResponse: Decodable {
    private enum CodingKeys: String, CodingKey {
        case responseCode = "response_code"
        case questions = "results"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let rawRespCode = try? values.decode(Int.self, forKey: .responseCode)
        let rawQuiz = try? values.decode(Array<Question>.self, forKey: .questions)
        
        guard let responseCode = rawRespCode,
              let quiz = rawQuiz
        else {
            throw QuizError.missingData
        }
        
        self.responseCode = responseCode
        self.questions = quiz
    }
}
