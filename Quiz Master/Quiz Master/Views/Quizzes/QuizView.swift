//
//  SessionView.swift
//  Quiz Master
//
//  Created by Izzat Syamil on 20/04/2024.
//

import SwiftUI

struct QuizView: View {
    var selectedCategory: Category
    var difficulty: Difficulty
    
    @EnvironmentObject var vm : QuizViewModel
    @EnvironmentObject var router: Router
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
                QuizPage(
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
        .onReceive(vm.$sessionEnded, perform: { hasEnd in
            if hasEnd {
                router.popTo(
                    to: .result(category: selectedCategory, diff: difficulty)
                )
            }
        })
        .onDisappear(perform: {
            if !vm.sessionEnded {
                vm.cleanSession()
            } else {
                //MARK: to prevent retry navigation bug
                vm.sessionEnded = false
            }
        })
    }
}

extension QuizView {
    func runLoadTask() {
        Task {
            await loadQuiz(
                categoryId: selectedCategory.id, level: difficulty.level
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

//MARK: Uncomment preview below will trigger timer
//#Preview {
//    do {
//        let previewer = try Previewer()
//        return QuizView(
//            selectedCategory: previewer.categories[0],
//            level: Level.easy
//        ).environmentObject(
//            QuizViewModel(
//                client: QuizClient(
//                    downloader: TestDownloader()
//                )
//            )
//        )
//        .environmentObject(Router())
//    } catch {
//        return Text("Error")
//    }
//}
