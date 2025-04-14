//
//  OutlineGradientView.swift
//  Persona Code
//
//  Created by Иван Семикин on 20/01/2025.
//

import SwiftUI

struct OutlineGradientButtonBackgroundView: View {
    var cornerRadius: CGFloat = 20
    var backgroundGradient: Gradient = Gradient(colors: [.blue.opacity(0.7), .purple.opacity(0.7)])
    
    @State private var gradientStart: CGFloat = 0.0
    
    var body: some View {
        ZStack {
            // Фоновый градиент
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(
                    LinearGradient(
                        gradient: backgroundGradient,
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

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

//#Preview {
//    OutlineGradientView()
//}
