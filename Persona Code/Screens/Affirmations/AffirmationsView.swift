//
//  AffirmationsView.swift
//  Persona Code
//
//  Created by Иван Семикин on 03/03/2025.
//

import SwiftUI

struct AffirmationsView: View {
    @EnvironmentObject private var coordinator: NavigationCoordinator
    @StateObject private var viewModel = AffirmationsViewModel.shared
    
    var body: some View {
        ZStack {
            BackgroundView(isAnimated: false)
            ShadowBackgroundView()
            
            VStack {
                // Горизонтальный список категорий
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 1) {
                        ForEach(viewModel.categories) { category in
                            Button(action: {
                                viewModel.selectedCategory = category
                            }) {
                                VStack {
                                    Image(systemName: category.icon)
                                        .font(.title)
                                        .foregroundColor(
                                            viewModel.selectedCategory == category
                                            ? .white
                                            : .gray
                                        )
                                    Text(category.displayName)
                                        .font(.caption)
                                        .foregroundColor(
                                            viewModel.selectedCategory == category
                                            ? .white
                                            : .gray
                                        )
                                }
                                .padding()
                                .background(
                                    viewModel.selectedCategory == category
                                    ? Color.brown.opacity(0.2)
                                    : Color.clear
                                )
                                .cornerRadius(10)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Тоггл с напоминаниями
                Toggle(isOn: $viewModel.isReminderEnabled) {
                    Text("Напоминание прочитать аффирмации")
                        .font(.caption)
                        .foregroundColor(.white)
                }
                .tint(.brown)
                .padding(.horizontal)
                .onChange(of: viewModel.isReminderEnabled) { isOn in
                    if isOn {
                        coordinator.present(.reminderPicker)
                    } else {
                        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                    }
                }
                
                // Переключатель для избранного
                Toggle(isOn: $viewModel.showFavoritesOnly) {
                    Text("Показывать только избранное")
                        .font(.caption)
                        .foregroundColor(.white)
                }
                .tint(.brown)
                .padding(.horizontal)
                
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
    }
}
