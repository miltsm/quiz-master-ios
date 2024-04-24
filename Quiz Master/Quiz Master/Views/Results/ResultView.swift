//
//  ResultView.swift
//  Quiz Master
//
//  Created by Izzat Syamil on 24/04/2024.
//

import SwiftUI

struct ResultView: View {
    
    //retry params
    @Bindable var selectedCategory: Category
    var level: Level
    
    @EnvironmentObject var vm : QuizViewModel
    @EnvironmentObject var router: Router
    
    @Environment(\.modelContext) private var context
    
    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .leading) {
                Text("\(selectedCategory.name) - Level \(level.rawValue)")
                    .background(.pink)
                    .foregroundColor(.white)
                    .font(.caption)
                Text("Your total score")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                Text("\(vm.totalScore)")
                    .font(.custom("score", size: 100.0))
                    .foregroundStyle(.mint)
                HStack {
                    VStack {
                        Text("Total correct answer")
                            .foregroundColor(.gray)
                            .font(.caption)
                        HStack {
                            Text("\(vm.answers.filter({ $0.isCorrect }).count)")
                                .foregroundColor(.indigo)
                                .font(.title)
                            Text("/ \(QUESTION_COUNT)")
                                .foregroundColor(.gray)
                                .font(.title)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    VStack {
                        Text("Time finished")
                            .foregroundColor(.gray)
                            .font(.caption)
                        Text("\(vm.timeTaken)s")
                            .foregroundColor(.indigo)
                            .font(.title)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding(20)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                .cornerRadius(10)
                .shadow(radius: 10)
            }
            Spacer()
            HStack {
                Button(action: {
                    router.popTo(
                        to: .session(category: selectedCategory, level: level)
                    )
                }) {
                    VStack {
                        Image(systemName: "timer")
                        Text("Retry").frame(maxWidth: .infinity)
                    }
                }
                .buttonStyle(.bordered)
                Button(action: {
                    router.navigateUp()
                }){
                    VStack {
                        Image(systemName: "hand.thumbsup.fill")
                        Text("All good").frame(maxWidth: .infinity)
                    }
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding(.all, 20)
        .background(.yellow)
        .onAppear(perform: {
//            selectedCategory.difficulties.first(where: { $0.level == level })?.score = vm.totalScore
            vm.calculateTimeTaken()
        })
        .onDisappear(perform: {
            vm.cleanSession()
        })
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        return ResultView(
            selectedCategory: previewer.categories[0], level: Level.easy
        )
        .environmentObject(
            QuizViewModel(
                client: QuizClient(downloader: TestDownloader())
            )
        )
        .environmentObject(Router())
    } catch {
        return Text("Error")
    }
}
