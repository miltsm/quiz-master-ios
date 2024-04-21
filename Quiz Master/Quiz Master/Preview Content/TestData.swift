//
//  TestData.swift
//  Quiz MasterTests
//
//  Created by Izzat Syamil on 21/04/2024.
//

import Foundation

let testQuiz_correct_answer_poisson: Data = """
      {
          "type": "multiple",
                      "difficulty": "easy",
                      "category": "General Knowledge",
          "question": "What is the French word for &quot;fish&quot;?",
          "correct_answer": "poisson",
          "incorrect_answers": [
              "fiche",
              "escargot",
              "mer"
          ]
      }
    """.data(using: .utf8)!

let testQuizzesData: Data = """
    {
        "response_code": 0,
        "results": [
            {
                "type": "multiple",
                "difficulty": "easy",
                "category": "General Knowledge",
                "question": "What zodiac sign is represented by a pair of scales?",
                "correct_answer": "Libra",
                "incorrect_answers": [
                    "Aries",
                    "Capricorn",
                    "Sagittarius"
                ]
            },
            {
                "type": "multiple",
                "difficulty": "easy",
                "category": "General Knowledge",
                "question": "What kind of aircraft was developed by Igor Sikorsky in the United States in 1942?",
                "correct_answer": "Helicopter",
                "incorrect_answers": [
                    "Stealth Blimp",
                    "Jet",
                    "Space Capsule"
                ]
            },
            {
                "type": "multiple",
                "difficulty": "easy",
                "category": "General Knowledge",
                "question": "Waluigi&#039;s first appearance was in what game?",
                "correct_answer": "Mario Tennis 64 (N64)",
                "incorrect_answers": [
                    "Wario Land: Super Mario Land 3",
                    "Mario Party (N64)",
                    "Super Smash Bros. Ultimate"
                ]
            },
            {
                "type": "multiple",
                "difficulty": "easy",
                "category": "General Knowledge",
                "question": "When someone is cowardly, they are said to have what color belly?",
                "correct_answer": "Yellow",
                "incorrect_answers": [
                    "Green",
                    "Red",
                    "Blue"
                ]
            },
            {
                "type": "multiple",
                "difficulty": "easy",
                "category": "General Knowledge",
                "question": "What was the name of the WWF professional wrestling tag team made up of the wrestlers Ax and Smash?",
                "correct_answer": "Demolition",
                "incorrect_answers": [
                    "The Dream Team",
                    "The Bushwhackers",
                    "The British Bulldogs"
                ]
            }
        ]
    }
""".data(using: .utf8)!
