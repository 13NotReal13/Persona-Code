//
//  SettingsView.swift
//  Persona Code
//
//  Created by Иван Семикин on 03/03/2025.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var coordinator: NavigationCoordinator
    @StateObject private var viewModel = SettingsViewModel.shared
    
    var body: some View {
        ZStack {
            BackgroundView(isAnimated: false)
            ShadowBackgroundView(isHighShadowLevel: true)
            
            Form {
                NotificationTogglesView()
                
                LanguagePickerView()
                
                ConfidentialityButtonsView()
                
                RestorePurchasesButtonView()
                
                RequestReviewButtonView()
                
                Section(header: Text("Поддержка")) {
                    Button("Связаться с разработчиком") {
                        ReviewRequestManager.shared.showFeedbackForm()
                    }
                }
                .listRowBackground(Color.white.opacity(0.1))
            }
            .scrollContentBackground(.hidden)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    NavigationBackButtonView { coordinator.pop() }
                }
                ToolbarItem(placement: .principal) {
                    CustomNavigationTitleView(title: "Настройки")
                }
            }
            .environmentObject(viewModel)
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        SettingsView()
            .preferredColorScheme(.dark)
            .environmentObject(NavigationCoordinator())
    }
}
