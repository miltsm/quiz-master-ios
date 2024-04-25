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
                "category": "Animals",
                "question": "By definition, where does an abyssopelagic animal live?",
                "correct_answer": "At the bottom of the ocean",
                "incorrect_answers": [
                    "In the desert",
                    "On top of a mountain",
                    "Inside a tree"
                ]
            },
            {
                "type": "multiple",
                "difficulty": "easy",
                "category": "Animals",
                "question": "The Kākāpō is a large, flightless, nocturnal parrot native to which country?",
                "correct_answer": "New Zealand",
                "incorrect_answers": [
                    "South Africa",
                    "Australia",
                    "Madagascar"
                ]
            },
            {
                "type": "multiple",
                "difficulty": "easy",
                "category": "Animals",
                "question": "What is the name of a rabbit&#039;s abode?",
                "correct_answer": "Burrow",
                "incorrect_answers": [
                    "Nest",
                    "Den",
                    "Dray"
                ]
            },
            {
                "type": "multiple",
                "difficulty": "easy",
                "category": "Animals",
                "question": "How many teeth does an adult rabbit have?",
                "correct_answer": "28",
                "incorrect_answers": [
                    "30",
                    "26",
                    "24"
                ]
            },
            {
                "type": "multiple",
                "difficulty": "easy",
                "category": "Animals",
                "question": "What is the collective noun for a group of crows?",
                "correct_answer": "Murder",
                "incorrect_answers": [
                    "Pack",
                    "Gaggle",
                    "Herd"
                ]
            },
            {
                "type": "multiple",
                "difficulty": "easy",
                "category": "Animals",
                "question": "How many legs do butterflies have?",
                "correct_answer": "6",
                "incorrect_answers": [
                    "2",
                    "4",
                    "0"
                ]
            },
            {
                "type": "multiple",
                "difficulty": "easy",
                "category": "Animals",
                "question": "What is Grumpy Cat&#039;s real name?",
                "correct_answer": "Tardar Sauce",
                "incorrect_answers": [
                    "Sauce",
                    "Minnie",
                    "Broccoli"
                ]
            },
            {
                "type": "multiple",
                "difficulty": "easy",
                "category": "Animals",
                "question": "What is the fastest  land animal?",
                "correct_answer": "Cheetah",
                "incorrect_answers": [
                    "Lion",
                    "Thomson&rsquo;s Gazelle",
                    "Pronghorn Antelope"
                ]
            },
            {
                "type": "multiple",
                "difficulty": "easy",
                "category": "Animals",
                "question": "What colour is the female blackbird?",
                "correct_answer": "Brown",
                "incorrect_answers": [
                    "Black",
                    "White",
                    "Yellow"
                ]
            },
            {
                "type": "multiple",
                "difficulty": "easy",
                "category": "Animals",
                "question": "What do you call a baby bat?",
                "correct_answer": "Pup",
                "incorrect_answers": [
                    "Cub",
                    "Chick",
                    "Kid"
                ]
            }
        ]
    }
""".data(using: .utf8)!
