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
                Section(header: Text("Уведомления")) {
                    Toggle("Напоминания об аффирмациях", isOn: $viewModel.isReminderEnabled)
                        .tint(.brown)
                        .onChange(of: viewModel.isReminderEnabled) { isOn in
                            viewModel.updateReminders()
                        }
                    
                    if viewModel.isReminderEnabled {
                        Button("Настройки уведомлений") {
                            coordinator.present(.reminderPicker(type: ReminderType.affirmation))
                        }
                        .font(.caption)
                        .foregroundColor(.brown)
                    }
                    
                    Toggle("Ежедневные вдохновения", isOn: $viewModel.isWishNotificationEnabled)
                        .tint(.brown)
                        .onChange(of: viewModel.isWishNotificationEnabled) { isOn in
                            viewModel.updateWishNotifications()
                        }
                    
                    if viewModel.isWishNotificationEnabled {
                        Button("Настройки уведомлений") {
                            coordinator.present(.reminderPicker(type: ReminderType.wish))
                        }
                        .font(.caption)
                        .foregroundColor(.brown)
                    }
                    
                    Button("Отправить тестовое уведомление") {
                        // NotificationManager.shared.sendTestNotification()
                    }
                    .foregroundStyle(.brown)
                }
                .listRowBackground(Color.white.opacity(0.1))
                
                Section(header: Text("Язык")) {
                    Picker("Язык интерфейса", selection: $viewModel.selectedLanguage) {
                        ForEach(viewModel.availableLanguages, id: \.self) { language in
                            Text(language).tag(language)
                        }
                    }
                }
                .listRowBackground(Color.white.opacity(0.1))
                
                Section(header: Text("Конфиденциальность")) {
                    Button("Политика конфиденциальности") {
                        if let url = URL(string: "https://example.com/privacy") {
                            UIApplication.shared.open(url)
                        }
                    }
                    Button("Условия использования") {
                        if let url = URL(string: "https://example.com/terms") {
                            UIApplication.shared.open(url)
                        }
                    }
                }
                .listRowBackground(Color.white.opacity(0.1))
                
                Section(header: Text("Покупки")) {
                    Button("Восстановить покупки") {
                        IAPManager.shared.restorePurchases()
                    }
                }
                .listRowBackground(Color.white.opacity(0.1))
                
                Section(header: Text("Оценки и отзывы")) {
                    Button("Оценить приложение") {
//                        SKStoreReviewController.requestReview()
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
