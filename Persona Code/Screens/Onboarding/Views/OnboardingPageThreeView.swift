//
//  OnboardingPageThreeView.swift
//  Persona Code
//
//  Created by Иван Семикин on 25/03/2025.
//

import SwiftUI

struct OnboardingPageThreeView: View {
    var body: some View {
        VStack {
            Spacer()
            
            FactsVisualView()
            
            Spacer()

            VStack(spacing: 24) {
                Text("🧠 УДИВИТЕЛЬНЫЕ ФАКТЫ")
                    .font(.title2.bold())
                    .multilineTextAlignment(.center)

                Text("Узнайте, на что способен человеческий мозг и тело. Каждый день — новый научный факт о возможностях организма, разума и восприятия, которые вдохновляют раскрывать собственный потенциал.")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
        }
    }
}

struct FactsVisualView: View {
    let icons = ["eye", "bolt", "chart.bar", "book", "waveform.path.ecg", "atom", "lightbulb"]

    var body: some View {
        GeometryReader { geo in
            let size = min(geo.size.width, geo.size.height)
            let radius = size * 0.35
            let center = CGPoint(x: geo.size.width / 2, y: geo.size.height / 2 + 10)

            ZStack {
                // Центральная иконка
                Image(systemName: "brain.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.ringColor1)
                    .position(center)

                // Вращающиеся факты вокруг
                ForEach(0..<icons.count, id: \.self) { i in
                    let angle = Angle(degrees: Double(i) / Double(icons.count) * 360)
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

#Preview {
    OnboardingPageThreeView()
        .background(BackgroundView(shadowLevel: .high))
        .preferredColorScheme(.dark)
}
