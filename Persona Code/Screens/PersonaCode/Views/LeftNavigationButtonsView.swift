//
//  LeftNavigationButtonView.swift
//  Persona Code
//
//  Created by Иван Семикин on 24/02/2025.
//

import SwiftUI

struct LeftNavigationButtonsView: View {
    @StateObject var personaCodeViewModel: PersonaCodeViewModel
    var isFullVersion: Bool
    
    @EnvironmentObject private var navigationCoordinator: NavigationCoordinator
    @AppStorage("currentLanguage") private var currentLanguage = "en"

    var selectedCategories: [CodeInfo] {
        if currentLanguage == "pl" {
            return InfoContentData_PL().categories
        } else if currentLanguage == "ru" {
            return InfoContentData_RU().categories
        } else {
            return InfoContentData_EN().categories
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(1..<selectedCategories.count + 1, id: \.self) { num in
                Spacer()
                
                let isLocked = !isFullVersion && num > 3
                
                Text(selectedCategories[num - 1].title)
                    .font(.custom(CustomFont.interVariable.rawValue, size: 17))
                    .foregroundStyle(isLocked ? .white.opacity(0.5) : .white)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .background(
                               Capsule()
                                   .stroke(Color.white, lineWidth: num == personaCodeViewModel.selectedSectionForLeftButtons && !isLocked ? 1 : 0)
                           )
                    .onTapGesture {
                        guard !isLocked else { return }
                        withAnimation {
                            personaCodeViewModel.isMenuOpen = false
                            personaCodeViewModel.scrollToSection.send(num)
                        }
                    }
                
                if num != 12 {
                    Divider()
                        .frame(height: 1)
                        .background(.white.opacity(0.4))
                }
            }
            
            if !isFullVersion {
                Button(action: {
                    
                }) {
                    Text("Unlock All")
                        .customText(fontSize: 17, customFont: .interDisplaySemiBold)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(12)
                        .background(OutlineGradientButtonBackgroundView())
                }
                .padding(.top, 8)
            }
        }
    }
}

#Preview {
    ZStack {
        BackgroundView()
        
        LeftNavigationButtonsView(
            personaCodeViewModel: PersonaCodeViewModel(),
            isFullVersion: false
        )
    }
}
