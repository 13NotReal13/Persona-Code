//
//  HowItWorksView.swift
//  Persona Code
//
//  Created by Иван Семикин on 01/03/2025.
//

import SwiftUI

struct HowItWorksView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Welcome to the \"Persona Code\" app!")
                    .font(.title2)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .multilineTextAlignment(.center)
                
                Text("""
                Here you can learn more about yourself and your potential through a unique system of 22 codes. The “Persona Code” app is developed using the most advanced AI model, capable of analyzing data with high accuracy and providing personalized recommendations.

                The system of 22 codes was not chosen by chance. It covers all key aspects of personality and life path, providing a comprehensive understanding of your talents, goals, and opportunities.
                """)
                .foregroundStyle(.white.opacity(0.8))
                
                Text("Why 22 codes?")
                    .font(.headline)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Text("""
                The 22 codes help explore different aspects of personality, from innate talents and strengths to hidden potentials and obstacles. AI reveals hidden connections and provides accurate recommendations.
                """)
                .foregroundStyle(.white.opacity(0.8))
                
                Text("How does it work?")
                    .font(.headline)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Text("""
                All you need is to enter your data. The system analyzes it using AI algorithms and creates a personal profile based on 12 categories.
                """)
                .foregroundStyle(.white.opacity(0.8))
                
                Text("Final thought")
                    .font(.headline)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Text("""
                The 22 codes symbolize different facets of your personality. Thanks to advanced AI technology, the “Persona Code” app can offer you precise and practical recommendations.
                """)
                .foregroundStyle(.white.opacity(0.8))
                
                Spacer()
            }
        }
        .scrollIndicators(.hidden)
        .foregroundStyle(.white)
    }
}

#Preview {
    ZStack {
        BackgroundView()
        
        HowItWorksView()
    }
}
