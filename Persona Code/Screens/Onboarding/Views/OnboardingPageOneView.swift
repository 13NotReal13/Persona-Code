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
                Text("🧬 Personality Code")
                    .font(.title2.bold())
                    .multilineTextAlignment(.center)

                Text("Discover a unique system of personality codes that helps you understand yourself better, identify hidden blocks and challenges in life, unlock your strengths, and find a path to achieving your goals.")
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
