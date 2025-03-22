//
//  AffirmationsView.swift
//  Persona Code
//
//  Created by Иван Семикин on 03/03/2025.
//

import SwiftUI

struct AffirmationsView: View {
    @EnvironmentObject private var coordinator: NavigationCoordinator
    @EnvironmentObject private var settings: SettingsViewModel
    @StateObject private var viewModel = AffirmationsViewModel.shared
    
    var body: some View {
        ZStack {
            BackgroundView(isShadow: true)
            
            VStack {
                ScrollCategoriesView(
                    selectedCategory: $viewModel.selectedCategory,
                    categories: viewModel.categories
                )
                
                ReminderToggleView(isReminderEnabled: $settings.isReminderEnabled)
                
                FavoritesToggleView(showFavoritesOnly: $viewModel.showFavoritesOnly)
                
                AffirmationsListView(
                    affirmations: viewModel.filteredAffirmations,
                    toggleFavorite: viewModel.toggleFavorite(for:)
                )
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    NavigationBackButtonView { coordinator.pop() }
                }
                
                ToolbarItem(placement: .principal) {
                    CustomNavigationTitleView(title: localizedString("Affirmations"))
                }
            }
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        AffirmationsView()
            .preferredColorScheme(.dark)
            .environmentObject(NavigationCoordinator.shared)
            .environmentObject(AffirmationsViewModel.shared)
    }
}
