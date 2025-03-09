//
//  SettingsView.swift
//  Persona Code
//
//  Created by Иван Семикин on 03/03/2025.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var coordinator: NavigationCoordinator
    @EnvironmentObject private var viewModel: SettingsViewModel
    
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
                
                SupportButtonView()
            }
            .scrollContentBackground(.hidden)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    NavigationBackButtonView { coordinator.pop() }
                }
                ToolbarItem(placement: .principal) {
                    CustomNavigationTitleView(title: localizedString("Settings"))
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
