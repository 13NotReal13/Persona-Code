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
            Spacer()

            CategoryCircleView()
            
            Spacer()

            VStack(spacing: 24) {
                Text("🧬 КОД ЛИЧНОСТИ")
                    .font(.title2.bold())
                    .multilineTextAlignment(.center)

                Text("Откройте для себя уникальную систему кодов личности, которая помогает глубже понять себя, выявить скрытые блоки и трудности в жизни, раскрыть сильные стороны и найти путь к достижению своих целей.")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
        }
    }
}

#Preview {
    OnboardingPageOneView()
        .preferredColorScheme(.dark)
}
