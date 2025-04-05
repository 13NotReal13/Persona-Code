//
//  LoadingPurchaseView.swift
//  Persona Code
//
//  Created by Иван Семикин on 05/04/2025.
//

import SwiftUI

struct LoadingPurchaseView: View {
    var body: some View {
        Color.black.opacity(0.4)
            .ignoresSafeArea()
            .transition(.opacity)

        VStack(spacing: 16) {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                .scaleEffect(2)

            Text("Processing purchase…")
                .foregroundColor(.white)
                .font(.headline)
        }
        .transition(.opacity)
    }
}

#Preview {
    LoadingPurchaseView()
}
