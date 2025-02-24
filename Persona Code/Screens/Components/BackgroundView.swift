//
//  BackgroundView.swift
//  Persona Code
//
//  Created by Иван Семикин on 23/02/2025.
//

import SwiftUI

struct BackgroundView: View {
    var isAnimated: Bool = true
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    .ringColor1,
                    .ringColor2
                ],
                startPoint: .bottom,
                endPoint: .top
            )
            
            RotatingNumberRingView(
                sizeOfRing: 0.67,
                fontSize: 16,
                direction: .left,
                colorOfCircle: Color.ringColor1,
                isAnimated: isAnimated,
                rotationInterval: 3
            )
            .offset(y: -155)
            
            RotatingNumberRingView(
                sizeOfRing: 0.51,
                fontSize: 15,
                direction: .right,
                colorOfCircle: Color.ringColor2,
                isAnimated: isAnimated,
                rotationInterval: 2
            )
            .offset(y: -155)
            
            RotatingNumberRingView(
                sizeOfRing: 0.35,
                fontSize: 14,
                direction: .left,
                colorOfCircle: Color.ringColor1,
                isAnimated: isAnimated,
                rotationInterval: 1
            )
                .offset(y: -155)
            
            Image(.personaBackground)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .offset(y: -70)
                .shadow(color: .white, radius: 10)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    BackgroundView()
}
