//
//  SessionView.swift
//  Quiz Master
//
//  Created by Izzat Syamil on 20/04/2024.
//

import SwiftUI

struct QuizView: View {
    var selectedCategory: Category
    var level: Level
    
    @EnvironmentObject var vm : QuizViewModel
    @State var isLoading = false
    @State private var error: QuizError?
    @State private var hasError = false
    
    @State private var currentPage = 0
    
    var body: some View {
        ZStack {
            switch(true) {
            case isLoading:
                ProgressView()
                    .progressViewStyle(.circular)
            case !vm.questions.isEmpty && !isLoading:
                QuizPageView(
                    pages: vm.questions.map {
                        QuizCard(
                            question: $0,
                            currentPage: $currentPage
                        )
                    },
                    currentPage: $currentPage
                )
            default:
                VStack {
                    Text("Unable to obtain questions")
                    Button(action: {
                        runLoadTask()
                    }, label: {
                        Image(systemName: "arrow.clockwise.circle")
                    })
                }
            }
        }
        .navigationTitle(selectedCategory.name)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.yellow)
        .task {
            runLoadTask()
        }
    }
}

extension QuizView {
    func runLoadTask() {
        Task {
            await loadQuiz(
                categoryId: selectedCategory.id, level: level
            )
        }
    }

    func loadQuiz(categoryId: Int, level: Level) async {
        isLoading = true
        do {
            try await vm.fetchQuiz(categoryId: categoryId, level: level)
        } catch {
            self.error = error as? QuizError ?? .unexpectedError(error: error)
            self.hasError = true
        }
        isLoading = false
    }
}

#Preview {
    QuizView(
        selectedCategory: Category(id: 9, name: "Test"),
        level: Level.easy
    ).environmentObject(
        QuizViewModel(
            client: QuizClient(
                downloader: TestDownloader()
            )
        )
    )
}
