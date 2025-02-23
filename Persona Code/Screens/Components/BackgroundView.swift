//
//  BackgroundView.swift
//  Persona Code
//
//  Created by Иван Семикин on 23/02/2025.
//

import SwiftUI

struct BackgroundView: View {
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
                fontSize: 15,
                direction: .left,
                colorOfCircle: Color.ringColor1
            )
            .offset(y: -155)
            
            RotatingNumberRingView(
                sizeOfRing: 0.51,
                fontSize: 14,
                direction: .right,
                colorOfCircle: Color.ringColor2
            )
            .offset(y: -155)
            
            RotatingNumberRingView(
                sizeOfRing: 0.35,
                fontSize: 13,
                direction: .left,
                colorOfCircle: Color.ringColor1
            )
                .offset(y: -155)
            
            Image(.personaBackground)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .offset(y: -70)
//                .mask {
//                    LinearGradient(
//                        gradient: Gradient(stops: [
//                            .init(color: .white, location: 0.8),
//                            .init(color: .clear, location: 1)
//                            ]
//                        ),
//                        startPoint: .top,
//                        endPoint: .bottom
//                    )
//                }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    BackgroundView()
}
