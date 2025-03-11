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
        Section(header: Text("Notifications")) {
            Toggle("Affirmation reminders", isOn: $viewModel.isReminderEnabled)
                .tint(.brown)
                .disabled(notificationStatus == .denied)
                .onChange(of: viewModel.isReminderEnabled) { isOn in
                    viewModel.updateReminders()
                }
            
            if viewModel.isReminderEnabled {
                Button("Notification settings") {
                    coordinator.present(.reminderPicker(type: ReminderType.affirmation))
                }
                .font(.caption)
                .foregroundColor(.brown)
            }
            
            Toggle("Amazing facts about the capabilities of the body and mind", isOn: $viewModel.isFactNotificationEnabled)
                .tint(.brown)
                .disabled(notificationStatus == .denied)
                .onChange(of: viewModel.isFactNotificationEnabled) { isOn in
                    viewModel.updateFactsNotifications()
                }
            
            if viewModel.isFactNotificationEnabled {
                Button("Notification settings") {
                    coordinator.present(.reminderPicker(type: ReminderType.dailyFact))
                }
                .font(.caption)
                .foregroundColor(.brown)
            }
            
            if notificationStatus == .denied {
                HStack {
                    Spacer()
                    
                    VStack(alignment: .center, spacing: 16) {
                        Text("Notifications disabled")
                            .font(.caption)
                            .foregroundStyle(.red)
                        
                        Button("Go to Settings") {
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
        .environmentObject(SettingsViewModel())
}
