//
//  BackgroundView.swift
//  Persona Code
//
//  Created by Иван Семикин on 23/02/2025.
//

import SwiftUI

struct BackgroundView: View {
    var isShadow: Bool = false
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.ringColor1, .ringColor2],
                startPoint: .bottom,
                endPoint: .top
            )
            .ignoresSafeArea()
            
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
            .ignoresSafeArea()
            .padding(.bottom, 50)
            
            if isShadow {
                Color.black.opacity(0.6)
                    .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    BackgroundView()
}
