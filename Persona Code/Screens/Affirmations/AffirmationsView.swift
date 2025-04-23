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
    
    @AppStorage("hasSeenAffirmationHint") private var hasSeenHint = false
    @State private var showHint = false
    
    var body: some View {
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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(BackgroundView(shadowLevel: .high))
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                NavigationBackButtonView { coordinator.pop() }
            }
            
            ToolbarItem(placement: .principal) {
                CustomNavigationTitleView(title: localizedString("Affirmations"))
            }
        }
        .onAppear {
            if !hasSeenHint {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {                showHint = true
                }
            }
        }
        .sheet(isPresented: $showHint) {
            VStack(spacing: 24) {
                Text("💬 What are affirmations?")
                    .customText(fontSize: 20, customFont: .interDisplaySemiBold)
                    .multilineTextAlignment(.center)
                    .padding(.top)

                Text("Affirmations are positive statements that help shift your mindset, boost self-confidence, and focus on your goals. By repeating them daily, you create a supportive inner state and program yourself for success.")
                    .customText(fontSize: 17)
                    .multilineTextAlignment(.leading)

                Toggle(isOn: $hasSeenHint) {
                    Text("Don't show again")
                        .customText(fontSize: 17)
                }
                .toggleStyle(CheckboxToggleStyle())
                .padding(.horizontal)
                
                Button {
                    showHint = false
                } label: {
                    ButtonLabelView(text: "Got it", fontSize: 17, widthMultiplyBy: 0.4)
                }
            }
            .padding()
            .presentationDetents([.height(380)])
            .presentationDragIndicator(.visible)
        }
    }
}

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: { configuration.isOn.toggle() }) {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                    .foregroundColor(.brown)
                    .font(.title2)
                configuration.label
            }
            .padding(.vertical, 4)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    NavigationStack {
        AffirmationsView()
            .preferredColorScheme(.dark)
            .environmentObject(NavigationCoordinator.shared)
            .environmentObject(AffirmationsViewModel.shared)
            .environmentObject(SettingsViewModel())
    }
}
