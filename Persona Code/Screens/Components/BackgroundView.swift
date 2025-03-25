//
//  BackgroundView.swift
//  Persona Code
//
//  Created by Иван Семикин on 23/02/2025.
//

import SwiftUI

enum ShadowLevel: CGFloat {
    case none = 0
    case medium = 0.5
    case high = 0.7
}

struct BackgroundView: View {
    var shadowLevel: ShadowLevel = .none
    
    @State private var isGlowing = false
    
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
                    .opacity(0.3)
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
            }
            .padding(.bottom, 50)
            
            GeometryReader { geo in
                Image(.backgroundSecondLayer)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width, height: geo.size.height)
                    .shadow(color: .white.opacity(isGlowing ? 0.9 : 0.2), radius: 30)
                    .opacity(isGlowing ? 0.7 : 0.2)
                    .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: isGlowing)
            }
            .padding(.bottom, 50)
            
            if shadowLevel != .none {
                Color.black.opacity(shadowLevel.rawValue)
            }
        }
        .ignoresSafeArea()
        .onAppear {
            isGlowing = true
        }
    }
}

#Preview {
    BackgroundView()
}
