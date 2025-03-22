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
        Form {
            NotificationTogglesView()
            
            LanguagePickerView()
            
            ConfidentialityButtonsView()
            
            RestorePurchasesButtonView()
            
            RequestReviewButtonView()
            
            SupportButtonView()
        }
        .scrollContentBackground(.hidden)
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                NavigationBackButtonView { coordinator.pop() }
            }
            ToolbarItem(placement: .principal) {
                CustomNavigationTitleView(title: localizedString("Settings"))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(BackgroundView(shadowLevel: .high))
        .environmentObject(viewModel)
    }
}

#Preview {
    NavigationStack {
        SettingsView()
            .preferredColorScheme(.dark)
            .environmentObject(NavigationCoordinator())
    }
}
