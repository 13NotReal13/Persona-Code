//
//  BackgroundView.swift
//  Persona Code
//
//  Created by Иван Семикин on 23/02/2025.
//

import SwiftUI

enum ShadowLevel: CGFloat {
    case medium = 0.4
    case high = 0.7
}

enum BlurRadius: CGFloat {
    case medium = 3
    case high = 10
}

struct BackgroundView: View {
    var shadowLevel: ShadowLevel = .medium
    var blurRadius: BlurRadius = .medium
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.ringColor1, .ringColor2],
                startPoint: .bottom,
                endPoint: .top
            )
            
            GeometryReader { geo in
                Image(.backgroundPerson)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width, height: geo.size.height)
                    .clipped()
                    .opacity(0.6)
                    .mask(
                        LinearGradient(
                            gradient: Gradient(stops: [
                                .init(color: .black, location: 0.0),
                                .init(color: .black, location: 0.8),
                                .init(color: .clear, location: 1.0)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .blur(radius: blurRadius.rawValue)
            }
            .padding(.bottom, 50)
            
            Color.black.opacity(shadowLevel.rawValue)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    BackgroundView()
}
