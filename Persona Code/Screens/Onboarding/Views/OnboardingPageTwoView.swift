//
//  OnboardingPageTwoView.swift
//  Persona Code
//
//  Created by Иван Семикин on 25/03/2025.
//

import SwiftUI

struct AffirmationVisualOne: View {
    let icons = ["sun.max", "heart.fill", "bolt.fill", "quote.bubble", "dollarsign.circle.fill", "briefcase.fill", "heart.circle.fill"]

    var body: some View {
        GeometryReader { geo in
            let size = min(geo.size.width, geo.size.height)
            let radius = size * 0.35
            let center = CGPoint(x: geo.size.width / 2, y: geo.size.height / 2 + 20) // чуть ниже, чтобы над ним была дуга

            ZStack {
                // Центральная иконка мозга
                Image(systemName: "brain.head.profile")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.ringColor1)
                    .position(center)

                // Иконки над мозгом в дуге
                ForEach(0..<icons.count, id: \.self) { i in
                    let startAngle = -220.0
                    let endAngle = 40.0
                    let angle = Angle(degrees: startAngle + Double(i) / Double(icons.count - 1) * (endAngle - startAngle))
                    let dx = cos(angle.radians)
                    let dy = sin(angle.radians)

                    let x = center.x + dx * radius
                    let y = center.y + dy * radius

                    Image(systemName: icons[i])
                        .resizable()
                        .scaledToFit()
                        .frame(width: 36, height: 36)
                        .foregroundColor(.ringColor1)
                        .position(x: x, y: y)
                }
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
    }
}

struct OnboardingPageTwoView: View {
    var body: some View {
        VStack {
            Spacer()
            
            AffirmationVisualOne()
            
            Spacer()

            VStack(spacing: 24) {
                Text("💬 Affirmations")
                    .font(.title2.bold())
                    .multilineTextAlignment(.center)

                Text("Choose affirmations from various categories and repeat them daily. They help you maintain a positive mindset, boost confidence, and move toward your goals. To stay consistent — enable reminders.")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
        }
    }
}

#Preview {
    OnboardingPageTwoView()
        .background(BackgroundView(shadowLevel: .high))
        .preferredColorScheme(.dark)
}
