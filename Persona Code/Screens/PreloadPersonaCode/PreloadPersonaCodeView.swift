//
//  PreloadPersonaCodeView.swift
//  Persona Code
//
//  Created by Иван Семикин on 23/02/2025.
//

import SwiftUI

struct PreloadPersonaCodeView: View {
    @Environment(\.dismiss) var dismiss
    
    let personaCode: ShortPersonaCodeData
    
    @StateObject private var viewModel = PreloadPersonaCodeViewModel()
    @State private var navigateToPersonaCode = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                
                VStack {
                    Spacer()
                    
                    if viewModel.loadWasFinished {
                        Button {
                            viewModel.showPurchaseModal = true
                        } label: {
                            Text("Открыть")
                                .customText(fontSize: 17)
                                .customButtonStyle(width: UIScreen.main.bounds.width * 0.6, shape: .capsule)
                        }
                    } else {
                        LoadProgressView(viewModel: viewModel)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    if viewModel.loadWasFinished {
                        NavigationBackButtonView { dismiss() }
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    CustomNavigationTitleView(title: "Загрузка Данных")
                }
            }
            .onAppear {
                viewModel.startLoading()
            }
            .navigationDestination(isPresented: $navigateToPersonaCode) {
                PersonaCodeView(
                    personaCodeData: PersonaCodeCalculation(
                        name: personaCode.name,
                        dateOfBirthday: personaCode.dateOfBirthday
                    ).personaCodeData,
                    isFromPreload: true
                )
            }
            .sheet(isPresented: $viewModel.showPurchaseModal) {
                PurchaseModalView(
                    isPresented: $viewModel.showPurchaseModal,
                    navigateToPersonaCode: $navigateToPersonaCode
                )
            }
        }
        .navigationBarBackButtonHidden()
        .onChange(of: navigateToPersonaCode) { isNavigating in
            if isNavigating {
                viewModel.savePersonaCode(personaCode: personaCode)
            }
        }
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
