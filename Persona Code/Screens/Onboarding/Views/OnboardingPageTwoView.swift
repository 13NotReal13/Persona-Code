//
//  OnboardingPageTwoView.swift
//  Persona Code
//
//  Created by Иван Семикин on 25/03/2025.
//

import SwiftUI

struct OnboardingPageTwoView: View {
    var body: some View {
        VStack {
            DecodingProcessVisualView()
            
            Spacer()

            VStack(spacing: 24) {
                Text("How does it work?")
                    .customText(fontSize: 22, customFont: .interDisplaySemiBold)
                    .multilineTextAlignment(.center)

                Text("The information you provide is used to decode your unique personality code, which becomes the key to your personal profile. Our algorithms match it with verified sources — scientific research, academic studies, and behavioral models — helping you uncover your strengths, thought patterns, and internal settings.")
                    .customText(fontSize: 17)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
        }
    }
}

struct DecodingProcessVisualView: View {
    let icons = ["key.fill", "text.magnifyingglass", "brain", "book.closed", "list.bullet.rectangle.portrait", "arrow.triangle.branch"]

    var body: some View {
        GeometryReader { geo in
            let size = min(geo.size.width, geo.size.height)
            let radius = size * 0.35
            let center = CGPoint(x: geo.size.width / 2, y: geo.size.height / 2)

            ZStack {
                // Центральный открытый замок
                Image(systemName: "lock.open")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.ringColor1)
                    .position(center)

                // Иконки-этапы вокруг
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
    OnboardingPageTwoView()
        .background(BackgroundView(shadowLevel: .high))
        .preferredColorScheme(.dark)
}
