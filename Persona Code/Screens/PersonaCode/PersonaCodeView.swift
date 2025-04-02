//
//  PersonaCodeView.swift
//  Persona Code
//
//  Created by Иван Семикин on 11/11/2024.
//

import SwiftUI

struct PersonaCodeView: View {
    @State var personaCodeData: PersonaCodeModel
    var isFromPreload: Bool
    
    @EnvironmentObject private var coordinator: NavigationCoordinator
    @StateObject private var viewModel = PersonaCodeViewModel()
    @ObservedObject private var storageManager = StorageManager.shared
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack {
                PersonalTitleView(personaCodeData: personaCodeData)
                
                PersonaCodeScrollView(
                    viewModel: viewModel,
                    personaCodeData: personaCodeData
                )
            }
            
            LeftMenuView(viewModel: viewModel)
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if !ReviewRequestManager.shared.reviewPromptWasShowing() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    checkReviewConditions()
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    if isFromPreload {
                        coordinator.popToRoot()
                    } else {
                        coordinator.pop()
                    }
                } label: {
                    Image(systemName: isFromPreload ? "house" : "chevron.left")
                        .customText(fontSize: 17)
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                DownloadPDFButtonView(viewModel: viewModel, personaCodeData: personaCodeData)
                    .opacity(viewModel.isMenuOpen ? 0.5 : 1)
            }
        }
        .sheet(isPresented: $viewModel.showShareSheet) {
            ShareSheet(items: viewModel.shareItems)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(BackgroundView(shadowLevel: .high))
    }
    
    private func checkReviewConditions() {
        let personaCodesCount = storageManager.historyPersonaCodeData.count
        
        ReviewRequestManager.shared.checkReviewConditions(personaCodesCount: personaCodesCount)
    }
}

#Preview {
    let dateComponents = DateComponents(year: 1994, month: 1, day: 19)
    let calendar = Calendar.current
    let date = calendar.date(from: dateComponents)!
    
    let personaCodeData = PersonaCodeCalculation(name: "Иван", dateOfBirthday: date)
    
    PersonaCodeView(personaCodeData: personaCodeData.personaCodeData, isFromPreload: true)
}
