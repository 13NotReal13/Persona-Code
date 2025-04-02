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
            Text("Show only Favorites")
                .customText(fontSize: 13)
        }
        .tint(.brown)
        .padding(.horizontal, 32)
    }
}

#Preview {
    ZStack {
        BackgroundView()
        
        FavoritesToggleView(showFavoritesOnly: .constant(true))
    }
}
