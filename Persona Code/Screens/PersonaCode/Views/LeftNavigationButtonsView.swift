//
//  LeftNavigationButtonView.swift
//  Persona Code
//
//  Created by Иван Семикин on 24/02/2025.
//

import SwiftUI

struct LeftNavigationButtonsView: View {
    @StateObject var personaCodeViewModel: PersonaCodeViewModel
    
    let shortPersonaCode: ShortPersonaCodeData
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
        VStack(alignment: .leading, spacing: 0) {
            ForEach(1..<selectedCategories.count + 1, id: \.self) { num in
                Spacer()
                
                let isLocked = !isFullVersion && num > 3
                
                HStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.white)
                        .frame(maxHeight: .infinity)
                        .frame(width: num == personaCodeViewModel.selectedSectionForLeftButtons ? 3 : 1)
                        .opacity(num == personaCodeViewModel.selectedSectionForLeftButtons ? 1 : 0.3)
                    
                    Text(selectedCategories[num - 1].title)
                        .font(.custom(CustomFont.interVariable.rawValue, size: 17))
                        .foregroundStyle(isLocked ? .white.opacity(0.4) : .white)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .lineLimit(2)
                        .onTapGesture {
                            guard !isLocked else { return }
                            withAnimation {
                                personaCodeViewModel.isMenuOpen = false
                                personaCodeViewModel.scrollToSection.send(num)
                            }
                        }
                }
                
                if num != 12 {
                    ZStack {
                        RoundedRectangle(cornerRadius: 1)
                            .padding(.horizontal)
                            .frame(height: 1)
                            .foregroundStyle(.black)
                            .shadow(color: .black.opacity(0.2), radius: 2, x: 2, y: 2)
                        
                        RoundedRectangle(cornerRadius: 1)
                            .padding(.horizontal)
                            .frame(height: 1)
                            .opacity(0.5)
                    }
                }
            }
            
            if !isFullVersion {
                Button {
                    navigationCoordinator.present(
                        .purchase(
                            personaCode: shortPersonaCode,
                            isFromPreloadScreen: false
                        )
                    )
                } label: {
                    Text("Unlock All")
                        .customText(fontSize: 17, customFont: .interDisplaySemiBold)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(12)
                        .background(OutlineGradientButtonBackgroundView())
                        .padding(.horizontal, 5)
                }
                .padding(.top, 8)
            }
        }
    }
}

#Preview {
    ZStack {
        BackgroundView(shadowLevel: .high)
        
        LeftNavigationButtonsView(
            personaCodeViewModel: PersonaCodeViewModel(),
            shortPersonaCode: ShortPersonaCodeData(
                name: "Ivan",
                dateOfBirthday: Date.now,
                dateCreationPersonaCode: Date.now
            ),
            isFullVersion: false
        )
    }
    .preferredColorScheme(.dark)
}
