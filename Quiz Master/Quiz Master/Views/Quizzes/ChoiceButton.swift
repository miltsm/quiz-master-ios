//
//  ChoiceButton.swift
//  Quiz Master
//
//  Created by Izzat Syamil on 21/04/2024.
//

import SwiftUI

struct ChoiceButton: View {
    
    var questionId: String
    var choice: Choice

    @Binding var chosen: Choice?

    @EnvironmentObject var vm : QuizViewModel
    
    var body: some View {
        Button(action: {
            chosen = choice
        }, label: {
            ZStack {
                Text("\(choice.answer)")
                    .foregroundStyle(
                        choice.id == chosen?.id ? .white : .blue
                    )
                    .frame(maxWidth: .infinity, maxHeight: 60)
            }
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(
                        choice.id == chosen?.id ? .mint : .gray.opacity(0.2)
                    )
            )
            .disabled(
                vm.answers.first(where: {
                    $0.questionId == questionId
                }) != nil
            )
        })
    }
}

#Preview {
    let choices = [
        Choice(id: 0, answer: "Choice 1"), 
        Choice(id: 1, answer: "Choice 2")
    ]
    return ChoiceButton(
        questionId: "question_1",
        choice: choices[0],
        chosen: .constant(choices[0])
    ).environmentObject(
        QuizViewModel(
            client: QuizClient(
                downloader: TestDownloader()
            )
        )
    )
}
