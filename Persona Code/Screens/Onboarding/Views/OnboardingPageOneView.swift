//
//  OnboardingPageOneView.swift
//  Persona Code
//
//  Created by Иван Семикин on 25/03/2025.
//

import SwiftUI

struct OnboardingPageOneView: View {
    var body: some View {
        VStack {
            KnowledgeVisualCircleView()
            
            Spacer()

            VStack(spacing: 24) {
                Text("Welcome!")
                    .customText(fontSize: 22, customFont: .interDisplaySemiBold)
                    .multilineTextAlignment(.center)

                Text("The Persona Code app is the result of synthesizing hundreds of psychological studies, dozens of books on human thinking and behavior, scientific works, and was developed with the participation of next-generation artificial intelligence.This is not astrology or fortune-telling — it is an advanced technology and a powerful tool for understanding yourself.")
                    .customText(fontSize: 17)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
        }
    }
}

struct KnowledgeVisualCircleView: View {
    let icons = ["book", "magnifyingglass", "brain.head.profile", "gearshape", "lightbulb", "network"]

    var body: some View {
        GeometryReader { geo in
            let size = min(geo.size.width, geo.size.height)
            let radius = size * 0.35
            let center = CGPoint(x: geo.size.width / 2, y: geo.size.height / 2)

            ZStack {
                // Центральная иконка CPU (мозг-алгоритм)
                Image(systemName: "cpu")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.ringColor1)
                    .position(center)

                // Иконки по кругу вокруг
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
        }
    }
}

#Preview {
    OnboardingPageOneView()
        .preferredColorScheme(.dark)
}
