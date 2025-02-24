//
//  LeftOpenMenuButtonView.swift
//  Persona Code
//
//  Created by Иван Семикин on 24/02/2025.
//

import SwiftUI

struct LeftOpenMenuButtonView: View {
    @StateObject var personaCodeViewModel: PersonaCodeViewModel
    
    @State private var iconIsLeft: Bool = false
    
    var body: some View {
        ZStack {
            Color.white.opacity(0.3)
                .cornerRadius(radius: 16, corners: [.topRight, .bottomRight])
            Image(systemName: iconIsLeft ? "chevron.left" : "chevron.right")
                .foregroundColor(.white)
        }
        .frame(width: 30, height: 400)
        .ignoresSafeArea()
        .onTapGesture {
            withAnimation {
                personaCodeViewModel.isMenuOpen.toggle()
            }
        }
        .onChange(of: personaCodeViewModel.isMenuOpen) { newValue in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                iconIsLeft = personaCodeViewModel.isMenuOpen
            }
        }
    }
}
