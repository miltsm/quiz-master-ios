//
//  NextLevelSheet.swift
//  Quiz Master
//
//  Created by Izzat Syamil on 25/04/2024.
//

import SwiftUI

struct NextLevelSheet: View {
    
    var selectedCategory: Category
    @Binding var shouldDisplayNextLevel: Bool
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Image(systemName: "hands.and.sparkles.fill")
                    .imageScale(.large)
                    .foregroundStyle(.yellow)
                    .padding(6)
                    .background {
                        Circle()
                            .fill(.indigo)
                    }
                Text("Congratulation!")
                    .foregroundStyle(.orange)
                    .font(.largeTitle)
            }
            Text("You have unlocked the next level")
            Spacer()
            Button(action: {
                //MARK: TO DO category detail as a destination
//                router.popTo(
//                    to: .session(
//                        category: selectedCategory,
//                        diff: selectedCategory.difficulties.filter({
//                            !$0.isUnlocked
//                        }).first!
//                    )
//                )
                //MARK: Dismiss modal - deadline constraint
                shouldDisplayNextLevel = false
                
            }, label: {
                Text(
                    //"Next level pls"
                    "OK"
                ).frame(maxWidth: .infinity)
            })
            .cornerRadius(20)
            .buttonStyle(.borderedProminent)
            .padding(.horizontal, 30)
            .padding(.bottom, 20)
        }
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        return NextLevelSheet(
            selectedCategory: previewer.categories[0],
            shouldDisplayNextLevel: .constant(true)
        )
            .environmentObject(Router())
    } catch {
        return Text("Error")
    }
}
