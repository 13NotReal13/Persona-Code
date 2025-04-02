//
//  LeftNavigationButtonView.swift
//  Persona Code
//
//  Created by Иван Семикин on 24/02/2025.
//

import SwiftUI

struct LeftNavigationButtonsView: View {
    @StateObject var personaCodeViewModel: PersonaCodeViewModel
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
                
                Text(selectedCategories[num - 1].title)
                    .customText(fontSize: 17)
                    .foregroundStyle(.white)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .overlay {
                        if num == personaCodeViewModel.selectedSectionForLeftButtons {
                            Capsule()
                                .stroke(Color.white, lineWidth: 1)
                        }
                    }
                    .onTapGesture {
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
        }
    }
}

#Preview {
    ZStack {
        BackgroundView()
        
        LeftNavigationButtonsView(personaCodeViewModel: PersonaCodeViewModel())
    }
}
