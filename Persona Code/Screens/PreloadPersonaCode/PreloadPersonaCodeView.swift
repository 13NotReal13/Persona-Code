//
//  PreloadPersonaCodeView.swift
//  Persona Code
//
//  Created by Иван Семикин on 23/02/2025.
//

import SwiftUI

struct PreloadPersonaCodeView: View {
    let personaCode: ShortPersonaCodeData
    
    @EnvironmentObject private var coordinator: NavigationCoordinator
    @StateObject private var viewModel = PreloadPersonaCodeViewModel()
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack {
                Spacer()
                
                if viewModel.loadWasFinished {
                    Button {
                        coordinator.present(.purchase(personaCode: personaCode))
                    } label: {
                        Text("Open")
                            .customText(fontSize: 17)
                            .customButtonStyle(width: UIScreen.main.bounds.width * 0.6, shape: .capsule)
                    }
                } else {
                    LoadProgressView(viewModel: viewModel)
                }
            }
            .onAppear {
                viewModel.startLoading(for: personaCode)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                if viewModel.loadWasFinished {
                    NavigationBackButtonView { coordinator.pop() }
                }
            }
            
            ToolbarItem(placement: .principal) {
                CustomNavigationTitleView(title: localizedString("Data Loading"))
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    ZStack {
        BackgroundView()
        
        PreloadPersonaCodeView(
            personaCode: ShortPersonaCodeData(
                name: "Иван",
                dateOfBirthday: .now,
                dateCreationPersonaCode: .now
            )
        )
    }
}
