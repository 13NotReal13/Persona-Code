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
                sizeOfRing: 0.6,
                fontSize: 17,
                direction: .left,
                colorOfCircle: Color.ringColor1
            )
                .offset(y: -100)
            
            RotatingNumberRingView(
                sizeOfRing: 0.45,
                fontSize: 15,
                direction: .right,
                colorOfCircle: Color.ringColor2
            )
                .offset(y: -100)
            
            RotatingNumberRingView(
                sizeOfRing: 0.3,
                fontSize: 13,
                direction: .left,
                colorOfCircle: Color.ringColor1
            )
                .offset(y: -100)
            
            Image(.persona2Clipped)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width * 1.3)
                .offset(y: +23)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    BackgroundView()
}
