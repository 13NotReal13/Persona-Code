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
            BackgroundView(isAnimated: false)
            ShadowBackgroundView()
            
            VStack {
                ScrollCategoriesView(
                    selectedCategory: $viewModel.selectedCategory,
                    categories: viewModel.categories
                )
                
                ReminderToggleView(isReminderEnabled: $settings.isReminderEnabled)
                
                FavoritesToggleView(showFavoritesOnly: $viewModel.showFavoritesOnly)
                
                // Список аффирмаций
                List(viewModel.filteredAffirmations) { affirmation in
                    HStack {
                        Text(affirmation.text)
                            .lineLimit(2)
                        
                        Spacer()
                        
                        Button(action: {
                            viewModel.toggleFavorite(for: affirmation)
                        }) {
                            Image(systemName: affirmation.isFavorite ? "star.fill" : "star")
                                .foregroundColor(affirmation.isFavorite ? .brown : .gray)
                        }
                    }
                    .padding()
                    .listRowInsets(
                        EdgeInsets(
                            top: 4,
                            leading: 16,
                            bottom: 4,
                            trailing: 16
                        )
                    )
                    .listRowBackground(Color.clear)
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(radius: 10, corners: .allCorners)
                }
                .scrollContentBackground(.hidden)
                .listStyle(PlainListStyle())
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    NavigationBackButtonView { coordinator.pop() }
                }
                
                ToolbarItem(placement: .principal) {
                    CustomNavigationTitleView(title: "Аффирмации")
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
            .environmentObject(SettingsViewModel.shared)
    }
}
