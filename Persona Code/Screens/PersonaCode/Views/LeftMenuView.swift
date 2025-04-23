//
//  LeftMenuView.swift
//  Persona Code
//
//  Created by Иван Семикин on 24/02/2025.
//

import SwiftUI

struct LeftMenuView: View {
    @StateObject var viewModel: PersonaCodeViewModel
    
    let shortPersonaCode: ShortPersonaCodeData
    var isFullVersion: Bool
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color.black.opacity(viewModel.isMenuOpen ? 0.5 : 0)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    withAnimation { viewModel.isMenuOpen = false }
                }
            
            HStack(spacing: 0) {
                LeftNavigationButtonsView(
                    personaCodeViewModel: viewModel,
                    shortPersonaCode: shortPersonaCode,
                    isFullVersion: isFullVersion
                )
                .frame(width: 260)
                .padding(.leading, 8)
                .padding(.trailing, 14)
                .background {
                    RoundedRectangle(cornerRadius: 40, style: .continuous)
                        .fill(.ultraThinMaterial)
                        .ignoresSafeArea()
                        .shadow(color: .white.opacity(0.3), radius: 10, x: 5, y: 0)
                }
                
                LeftOpenMenuButtonView(personaCodeViewModel: viewModel)
            }
            .offset(x: viewModel.isMenuOpen ? 0 : -282)
        }
    }
}

#Preview {
    ZStack {
        BackgroundView(shadowLevel: .high)
        
        LeftMenuView(
            viewModel: PersonaCodeViewModel(),
            shortPersonaCode: ShortPersonaCodeData(
                name: "Ivan",
                dateOfBirthday: Date.now,
                dateCreationPersonaCode: Date.now
            ),
            isFullVersion: false
        )
        .environmentObject(PersonaCodeViewModel())
        .preferredColorScheme(.light)
    }
    .preferredColorScheme(.dark)
}
