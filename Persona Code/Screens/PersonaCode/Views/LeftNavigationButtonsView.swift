//
//  LeftNavigationButtonView.swift
//  DestinyMatrix
//
//  Created by Иван Семикин on 12/11/2024.
//

import SwiftUI

struct LeftNavigationButtonsView: View {
    @StateObject var matrixViewModel: PersonaCodeViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(1..<14) { num in
                Spacer()
                
                Text(HelpInfoViewModel().categories[num - 1].title)
                    .customText(fontSize: 17, textColor: .white)
                    .foregroundStyle(.white)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .overlay {
                        if num == matrixViewModel.selectedSectionForLeftButtons {
                            Capsule()
                                .stroke(Color.white, lineWidth: 1)
                        }
                    }
                    .onTapGesture {
                        
                        withAnimation {
                            matrixViewModel.isMenuOpen = false
                            matrixViewModel.selectedSection = num
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
        AnimatedStarryBackgroundView()
        
        LeftNavigationButtonsView(matrixViewModel: PersonaCodeViewModel())
    }
}
