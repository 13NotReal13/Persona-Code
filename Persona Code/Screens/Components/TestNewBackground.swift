//
//  TestNewBackground.swift
//  Persona Code
//
//  Created by Иван Семикин on 19/03/2025.
//

import SwiftUI

struct TestNewBackground: View {
    let opacity: CGFloat
    
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
                    .opacity(opacity)
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    TestNewBackground(opacity: 0.2)
}
