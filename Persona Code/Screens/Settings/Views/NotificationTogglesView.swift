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
    
    @State private var notificationStatus: UNAuthorizationStatus = .notDetermined
    
    var body: some View {
        Section(header: Text("Уведомления")) {
            Toggle("Напоминания об аффирмациях", isOn: $viewModel.isReminderEnabled)
                .tint(.brown)
                .disabled(notificationStatus == .denied)
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
                .disabled(notificationStatus == .denied)
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
            
            if notificationStatus == .denied {
                HStack {
                    Spacer()
                    
                    VStack(alignment: .center, spacing: 16) {
                        Text("Уведомления отключены")
                            .font(.caption)
                            .foregroundStyle(.red)
                        
                        Button("Перейти в настройки") {
                            openAppSettings()
                        }
                    }
                    
                    Spacer()
                }
            }
        }
        .listRowBackground(Color.white.opacity(0.1))
        .onAppear {
            checkNotificationStatus()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            checkNotificationStatus()
        }
    }
    
    // 🔄 Логируем статус в консоль для отладки
    private func checkNotificationStatus() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                self.notificationStatus = settings.authorizationStatus
            }
        }
    }
    
    // Переход в настройки приложения
    private func openAppSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url)
        }
    }
}

#Preview {
    NotificationTogglesView()
        .environmentObject(NavigationCoordinator.shared)
        .environmentObject(SettingsViewModel.shared)
}
