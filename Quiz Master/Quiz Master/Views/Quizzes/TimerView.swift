//
//  TimerView.swift
//  Quiz Master
//
//  Created by Izzat Syamil on 24/04/2024.
//

import SwiftUI

struct TimerView: View {
    @Binding var progress: Float
    @Binding var timeLeft: Int
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 4)
                .opacity(0.3)
                .foregroundColor(.orange)
            Circle()
                .trim(from: 0, to: CGFloat(min(progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
                .foregroundColor(.orange)
                .rotationEffect(Angle(degrees: 270))
            Text("\(timeLeft)").font(.largeTitle)
            
        }
        .animation(.linear(duration: 1.0), value: progress)
    }
}

#Preview {
    TimerView(
        progress: .constant(Float(0.8)),
        timeLeft: .constant(30)
    )
}
