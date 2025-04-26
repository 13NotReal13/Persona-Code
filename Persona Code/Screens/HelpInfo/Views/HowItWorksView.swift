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
                Text("Welcome!")
                    .font(.title2)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .multilineTextAlignment(.center)
                
                Text("""
                The “Persona Code” app is the result of synthesizing hundreds of psychological studies, dozens of books on human behavior and thinking, scientific research, and has been developed with the help of next-generation artificial intelligence capable of analyzing data with high precision and providing personalized recommendations. Every part of the app is thoughtfully designed to bring you maximum benefit without unnecessary information.
                """)
                .foregroundStyle(.white.opacity(0.8))
                
                Text("How does it work?")
                    .font(.headline)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Text("""
                     The app uses the data you provide — your name and date of birth — as a starting point. This information allows the system to generate a unique numerical code, which becomes the key to your personal profile.
                     
                     Based on this code, the system analyzes verified sources: psychological research, scientific publications, and behavioral pattern analysis. The algorithms do not “guess” and are not based on astrology — they help reveal possible thinking patterns, strengths, and internal traits typical for your personality type.
                     """)
                .foregroundStyle(.white.opacity(0.8))
                
                Text("What will you get?")
                    .font(.headline)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Text("""
                You will receive a structured description of the key qualities of your personality, possible inner conflicts, and areas for growth.
                This information will become a tool for self-reflection — helping you better understand yourself, your habits, and how you interact with the world around you.
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
