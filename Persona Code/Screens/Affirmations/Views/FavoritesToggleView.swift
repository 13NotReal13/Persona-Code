//
//  FavoritesToggleView.swift
//  Persona Code
//
//  Created by Иван Семикин on 04/03/2025.
//

import SwiftUI

struct FavoritesToggleView: View {
    @Binding var showFavoritesOnly: Bool
    
    var body: some View {
        Toggle(isOn: $showFavoritesOnly) {
            Text("Показывать только избранное")
                .font(.caption)
                .foregroundColor(.white)
        }
        .tint(.brown)
        .padding(.horizontal, 32)
    }
}

#Preview {
    ZStack {
        BackgroundView(isAnimated: false)
        
        ShadowBackgroundView()
        
        FavoritesToggleView(showFavoritesOnly: .constant(true))
    }
}
