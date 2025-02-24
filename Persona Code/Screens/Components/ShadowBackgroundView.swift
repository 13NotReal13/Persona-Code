//
//  ShadowBackgroundView.swift
//  Persona Code
//
//  Created by Иван Семикин on 24/02/2025.
//

import SwiftUI

struct ShadowBackgroundView: View {
    var body: some View {
        LinearGradient(
            stops: [
                .init(color: .black.opacity(0.8), location: 0),
                .init(color: .black.opacity(0.4), location: 1)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
}

#Preview {
    ShadowBackgroundView()
}
