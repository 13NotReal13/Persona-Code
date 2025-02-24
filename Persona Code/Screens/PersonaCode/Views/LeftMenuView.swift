//
//  LeftMenuView.swift
//  DestinyMatrix
//
//  Created by Иван Семикин on 09/12/2024.
//

import SwiftUI

struct LeftMenuView: View {
    @StateObject var viewModel: PersonaCodeViewModel
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color.black.opacity(viewModel.isMenuOpen ? 0.5 : 0)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    withAnimation { viewModel.isMenuOpen = false }
                }
            
            ZStack(alignment: .leading) {
                BackgroundLeftMenuView()
                    .frame(width: 282)
                
                HStack(spacing: 0) {
                    LeftNavigationButtonsView(matrixViewModel: viewModel)
                        .frame(width: 250)
                        .padding(.horizontal)
                    
                    LeftOpenMenuButtonView(personaCodeViewModel: viewModel)
                }
            }
            .offset(x: viewModel.isMenuOpen ? 0 : -282)
        }
    }
}
