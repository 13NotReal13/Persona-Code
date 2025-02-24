//
//  BackgroundLeftMenuView.swift
//  Persona Code
//
//  Created by Иван Семикин on 24/02/2025.
//

import SwiftUI

struct BackgroundLeftMenuView: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [Color.ringColor2, Color.ringColor1]),
            startPoint: .top,
            endPoint: .bottom
        )
        .cornerRadius(radius: 24, corners: [.topRight, .bottomRight])
        .ignoresSafeArea(edges: .vertical)
    }
}
