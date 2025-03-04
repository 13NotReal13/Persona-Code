//
//  NotificationTogglesView.swift
//  Persona Code
//
//  Created by Иван Семикин on 04/03/2025.
//

import SwiftUI

struct NotificationTogglesView: View {
    @EnvironmentObject private var coordinator: NavigationCoordinator
    @EnvironmentObject private var viewModel: SettingsViewModel
    
    var body: some View {
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
    }
}

#Preview {
    NotificationTogglesView()
        .environmentObject(NavigationCoordinator.shared)
        .environmentObject(SettingsViewModel.shared)
}
