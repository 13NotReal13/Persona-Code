//
//  LeftOpenMenuButtonView.swift
//  DestinyMatrix
//
//  Created by Иван Семикин on 09/12/2024.
//

import SwiftUI

struct LeftOpenMenuButtonView: View {
    @StateObject var matrixViewModel: PersonaCodeViewModel
    
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
                matrixViewModel.isMenuOpen.toggle()
            }
        }
        .onChange(of: matrixViewModel.isMenuOpen) { newValue in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                iconIsLeft = matrixViewModel.isMenuOpen
            }
        }
    }
}
