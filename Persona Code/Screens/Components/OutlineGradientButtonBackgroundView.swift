//
//  OutlineGradientView.swift
//  Persona Code
//
//  Created by Иван Семикин on 20/01/2025.
//

import SwiftUI

struct OutlineGradientButtonBackgroundView: View {
    var cornerRadius: CGFloat = 20
    
    @State private var gradientStart: CGFloat = 0.0
    
    var body: some View {
        ZStack {
            // Фоновый градиент
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(Color.black.opacity(0.4))

            // Градиентная обводка с анимацией
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(
                    AngularGradient(
                        gradient: Gradient(colors: [.blue, .purple, .pink, .orange, .yellow, .blue]),
                        center: .center,
                        startAngle: .degrees(gradientStart),
                        endAngle: .degrees(gradientStart + 360)
                    ),
                    lineWidth: 2
                )
        }
        .onAppear {
            withAnimation(.linear(duration: 4).repeatForever(autoreverses: false)) {
                gradientStart = 360
            }
        }
    }
}

#Preview {
    ZStack {
        BackgroundView(shadowLevel: .high)
        
        Text("Полная версия")
            .preferredColorScheme(.dark)
            .customText(fontSize: 17, customFont: .interDisplaySemiBold)
            .padding()
            .background(OutlineGradientButtonBackgroundView())
    }
}
