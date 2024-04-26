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
    var difficulty: Difficulty
    
    @Environment(\.modelContext) private var context
    @EnvironmentObject var vm : QuizViewModel
    @EnvironmentObject var router: Router
    
    @State private var shouldDisplayNextLevelSheet = false
    
    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .leading) {
                Text("\(selectedCategory.name) - Level \(difficulty.level.rawValue)")
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
                        to: .session(category: selectedCategory, diff: difficulty)
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
        .sheet(isPresented: $shouldDisplayNextLevelSheet, content: {
            NextLevelSheet(
                selectedCategory: selectedCategory,
                shouldDisplayNextLevel: $shouldDisplayNextLevelSheet
            ).presentationDetents(
                [.fraction(0.3)]
            )
        })
        .onAppear(perform: {
            saveResult()
        })
        .onDisappear(perform: {
            vm.cleanSession()
        })
    }
}

extension ResultView {
    private func saveResult() {
        vm.calculateTimeTaken()
       
        let newAttempt = vm.getSessionAttempt()
        
        let isNewHighScore = difficulty.attempts.filter(
            { $0.score > newAttempt.score }
        ).isEmpty
        
        let isBestTime = difficulty.attempts.filter({
            $0.totalTimeTaken > 0 && $0.totalTimeTaken < newAttempt.totalTimeTaken
        }).isEmpty && newAttempt.beatsMinScoreThreshold
        
        print("is new highscore: \(isNewHighScore)")
        print("is new best time: \(isBestTime)")
        
        if isNewHighScore {
            difficulty.highScore = newAttempt.score
        }
        
        if isBestTime {
            difficulty.bestTime = newAttempt.totalTimeTaken
        }
    
        achievementRewarding(attempt: newAttempt)
        determineUnlocksAndDisplayAchievements(attempt: newAttempt)
        newAttempt.difficulty = difficulty
        context.insert(newAttempt)
    }
    
    private func achievementRewarding(attempt: Attempt) {
        
        //var newAchievements: [Achievement] = []
        let currentLevel = difficulty.level
        
        if self.difficulty.attempts.isEmpty
            &&
            attempt.totalCorrectAnswer == QUESTION_COUNT {
            var achievement2: AchievementType
            
            achievement2 = switch(currentLevel) {
            case .medium:
                AchievementType.allCorrectFirstTry
            case .hard:
                AchievementType.allCorrectFirstTryHard
            default:
                AchievementType.allCorrectFirstTry
            }
            
            context.insert(
                Achievement(
                    type: achievement2,
                    when: attempt.when)
            )
        }
        
        if attempt.beatsMinScoreThreshold
            && attempt.totalTimeTaken <= MAX_TIMER_COUNT / 2 {
            
            var achievement1: AchievementType
            
            achievement1 = switch(currentLevel) {
            case .medium:
                AchievementType.beatUnderHalfOfTimerTotal
            case .hard:
                AchievementType.allCorrectFirstTryHard
            default:
                AchievementType.beatUnderHalfOfTimerTotalEasy}
            
            context.insert(
                Achievement(
                    type: achievement1,
                    when: attempt.when
                )
            )
        }
    }
    
    private func determineUnlocksAndDisplayAchievements(attempt: Attempt) {
        //MARK: Determine level unlock
        if attempt.beatsMinScoreThreshold && difficulty.level != .hard {
            selectedCategory.difficulties.filter({
                !$0.isUnlocked
            }).first?.isUnlocked = true
            shouldDisplayNextLevelSheet = true
        }
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        return ResultView(
            selectedCategory: previewer.categories[0],
            difficulty: Difficulty(
                level: previewer.categories[0].difficulties[0].level
            )
        )
        .environmentObject(
            QuizViewModel(
                client: QuizClient(downloader: TestDownloader())
            )
        )
        .environmentObject(Router())
        .modelContainer(previewer.container)
    } catch {
        return Text("Error")
    }
}
