//
//  LeftNavigationButtonView.swift
//  Persona Code
//
//  Created by Иван Семикин on 24/02/2025.
//

import SwiftUI

struct LeftNavigationButtonsView: View {
    @StateObject var personaCodeViewModel: PersonaCodeViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(1..<13) { num in
                Spacer()
                
                Text(HelpInfoViewModel().categories[num - 1].title)
                    .customText(fontSize: 17, textColor: .white)
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
                            personaCodeViewModel.selectedSection = num
                        }
                    }
                
                if num != 13 {
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
