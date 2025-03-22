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
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.ringColor1, .ringColor2],
                startPoint: .bottom,
                endPoint: .top
            )
            
            GeometryReader { geo in
                Image(.test2)
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
            
            if shadowLevel != .none {
                Color.black.opacity(shadowLevel.rawValue)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    BackgroundView()
}
