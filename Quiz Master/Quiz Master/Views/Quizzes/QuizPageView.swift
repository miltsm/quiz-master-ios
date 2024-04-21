//
//  QuizPageView.swift
//  Quiz Master
//
//  Created by Izzat Syamil on 21/04/2024.
//

import SwiftUI

struct QuizPageView<Page: View>: View {
    var pages: [Page]
    @Binding var currentPage: Int
    
    @EnvironmentObject var vm : QuizViewModel
    
    var body: some View {
        VStack {
            HStack {
                ForEach(0...9, id: \.self) { i in
                    switch(true) {
                    case currentPage == i:
                        Circle().fill(.indigo).frame(width: 10)
//                    case answer != nil && answer.isCorrect:
//                        Circle().fill(.green).frame(width: 10)
//                    case answer != nil && !answer.isCorrect:
//                        Circle().fill(.red).frame(width: 10)
                    case i > currentPage:
                        Circle().fill(.white.opacity(0.7)).frame(width: 10)
                    default:
                        Circle().fill(.indigo).frame(width: 10)
                    }
                    
                }
            }
            //PageControl(currentPage: $currentPage)
            PageViewController(pages: pages, currentPage: $currentPage)
        }
    }
}

#Preview {
    QuizPageView(
        pages: [
            QuizCard(
                question: Question(
                    question: "Test?",
                    correctAnswer: "Yes",
                    incorrects: ["Idk", "Maybe", "No"],
                    choices: [
                        Choice(id: 0, answer: "Yes"),
                        Choice(id: 1, answer: "Yes"),
                        Choice(id: 2, answer: "Yes"),
                        Choice(id: 3, answer: "Yes")
                    ]
                ),
                currentPage: .constant(1)
            )
        ],
        currentPage: .constant(0)
    )
    .environmentObject(
        QuizViewModel(
            client: QuizClient(
                downloader: TestDownloader()
            )
        )
    )
}
