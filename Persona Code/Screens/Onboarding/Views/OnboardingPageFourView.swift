//
//  OnboardingPageFourView.swift
//  Persona Code
//
//  Created by Иван Семикин on 25/03/2025.
//

import SwiftUI

struct FinalSpiralVisualView: View {
    let dotCount = 100

    var body: some View {
        GeometryReader { geo in
            let center = CGPoint(x: geo.size.width / 2, y: geo.size.height / 2)
            let maxRadius = min(geo.size.width, geo.size.height) * 0.45

            ZStack {
                // Точки по спирали
                ForEach(0..<dotCount, id: \.self) { i in
                    let angle = Double(i) * 0.25
                    let radius = Double(i) / Double(dotCount) * maxRadius
                    let x = center.x + CGFloat(cos(angle) * radius)
                    let y = center.y + CGFloat(sin(angle) * radius)

                    Circle()
                        .fill(Color.ringColor1.opacity(0.3 + 0.7 * Double(i) / Double(dotCount)))
                        .frame(width: 3, height: 3)
                        .position(x: x, y: y)
                }

                // Центральная фигура человека
                Image(systemName: "figure.stand")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.ringColor1)
                    .position(center)
            }
        }
    }
}

struct OnboardingPageFourView: View {
    var body: some View {
        VStack {
            Spacer()
            
            FinalSpiralVisualView()
            
            Spacer()

            VStack(spacing: 24) {
                Text("✨ Begin Your Journey")
                    .font(.title2.bold())
                    .multilineTextAlignment(.center)

                Text("Use your Personality Code as a personal guide. It will help you understand yourself, overcome internal barriers, deal with life’s challenges, and move toward your goals with clarity and confidence.")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
        }
    }
}

#Preview {
    OnboardingPageFourView()
        .background(BackgroundView(shadowLevel: .high))
        .preferredColorScheme(.dark)
}
