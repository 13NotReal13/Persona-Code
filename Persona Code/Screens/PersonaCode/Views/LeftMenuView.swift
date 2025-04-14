//
//  LeftMenuView.swift
//  Persona Code
//
//  Created by Иван Семикин on 24/02/2025.
//

import SwiftUI

struct LeftMenuView: View {
    @StateObject var viewModel: PersonaCodeViewModel
    var isFullVersion: Bool
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color.black.opacity(viewModel.isMenuOpen ? 0.5 : 0)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    withAnimation { viewModel.isMenuOpen = false }
                }
            
            ZStack(alignment: .leading) {
                Color.black
                    .cornerRadius(radius: 24, corners: [.bottomRight, .topRight])
                    .frame(width: 282)
                    .ignoresSafeArea()
                    .shadow(color: Color.white.opacity(0.1), radius: 10, x: 4, y: 0)
                
                HStack(spacing: 0) {
                    LeftNavigationButtonsView(
                        personaCodeViewModel: viewModel,
                        isFullVersion: isFullVersion
                    )
                        .frame(width: 250)
                        .padding(.horizontal)
                    
                    LeftOpenMenuButtonView(personaCodeViewModel: viewModel)
                }
            }
            .offset(x: viewModel.isMenuOpen ? 0 : -282)
        }
    }
}

#Preview {
    ZStack {
        BackgroundView(shadowLevel: .high)
        
        LeftMenuView(viewModel: PersonaCodeViewModel(), isFullVersion: false)
            .environmentObject(PersonaCodeViewModel())
    }
}
