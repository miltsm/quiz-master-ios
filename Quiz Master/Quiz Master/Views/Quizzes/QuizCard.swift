//
//  QuizCard.swift
//  Quiz Master
//
//  Created by Izzat Syamil on 21/04/2024.
//

import SwiftUI

struct QuizCard: View {
    var question: Question
    
    @Binding var currentPage: Int
    
    @EnvironmentObject var vm : QuizViewModel
    @State private var chosen: Choice?
    
    @State private var showResult: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Text("\(question.question)").font(.largeTitle)
                    .padding()
                Grid {
                    GridRow {
                        ForEach(question.choices[..<2]) { c in
                            ChoiceButton(
                                questionId: question.id,
                                choice: c,
                                chosen: $chosen
                            )
                        }
                    }
                    GridRow {
                        ForEach(question.choices[2..<4]) { c in
                            ChoiceButton(
                                questionId: question.id,
                                choice: c,
                                chosen: $chosen
                            )
                        }
                    }
                }
                Spacer()
                Button(action: {
                    vm.submitAnswer(
                        questionId: question.id,
                        choice: chosen!
                    )
                    showResult = true
                }) {
                    Text("Confirm").frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .disabled(chosen == nil)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .cornerRadius(10)
            .padding(.all, 10)
            .background(content: {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                .cornerRadius(10)
                .shadow(radius: 10)
            })
        }
        .padding()
        .background(.yellow)
        .sheet(
            isPresented: $showResult, onDismiss: onResultDismiss
        ){
            VStack {
                Spacer()
                
                let answer = vm.answers.first(
                    where: { $0.questionId == question.id }
                ) ?? nil
                
                if (answer?.isCorrect == true) {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                    Text("Correct").font(.largeTitle)
                } else {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.red)
                    Text("Incorrect").font(.largeTitle)
                    HStack {
                        Text("The correct answer is").font(.caption2)
                        Text("\(answer?.correctAnswer ?? "Test")")
                            .font(.caption)
                            .foregroundColor(.indigo)
                    }
                }
                
                Spacer()
                Button(
                    action: { showResult = false },
                    label: {
                        Text("Next").frame(maxWidth: .infinity)
                    }
                )
                .buttonStyle(.borderedProminent)
            }
            .padding(.all, 30)
            .presentationDetents([.fraction(0.3)])
        }
    }
}

extension QuizCard {
    func onResultDismiss() {
        if currentPage < QUESTION_COUNT - 1 {
            currentPage = currentPage + 1
        }
        //MARK: TODO redirect result screen
    }
}

#Preview {
    QuizCard(
        question: Question(
            question: "Test?",
            correctAnswer: "Yes",
            incorrects: ["Idk", "Maybe", "No"],
            choices: [
                Choice(id: 0, answer: "Yes"),
                Choice(id: 1, answer: "No"),
                Choice(id: 2, answer: "Maybe"),
                Choice(id: 3, answer: "Idk")
            ]
        ),
        currentPage: .constant(0)
    ).environmentObject(
        QuizViewModel(
            client: QuizClient(
                downloader: TestDownloader()
            )
        )
    )
}
