//
//  OutlineGradientView.swift
//  Persona Code
//
//  Created by Иван Семикин on 13/04/2025.
//

import SwiftUI

struct OutlineGradientView: View {
    @State private var gradientStart: CGFloat = 0.0

    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .stroke(
                AngularGradient(
                    gradient: Gradient(colors: [.blue, .purple, .pink, .orange, .yellow, .blue]),
                    center: .center,
                    startAngle: .degrees(gradientStart),
                    endAngle: .degrees(gradientStart + 360)
                ),
                lineWidth: 2
            )
            .onAppear {
                withAnimation(.linear(duration: 4).repeatForever(autoreverses: false)) {
                    gradientStart = 360
                }
            }
    }
}

#Preview {
    OutlineGradientView()
}
