//
//  ShadowBackgroundView.swift
//  Persona Code
//
//  Created by Иван Семикин on 24/02/2025.
//

import SwiftUI

struct ShadowBackgroundView: View {
    var isHighShadowLevel: Bool = false
    
    var body: some View {
        LinearGradient(
            stops: [
                .init(color: .black.opacity(isHighShadowLevel ? 0.9 : 0.7), location: 0),
                .init(color: .black.opacity(isHighShadowLevel ? 0.7 : 0.3), location: 1)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
}

#Preview {
    ShadowBackgroundView(isHighShadowLevel: true)
}
