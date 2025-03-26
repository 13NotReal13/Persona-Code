//
//  ReminderToggleView.swift
//  Persona Code
//
//  Created by Иван Семикин on 04/03/2025.
//

import SwiftUI

struct ReminderToggleView: View {
    @Binding var isReminderEnabled: Bool
    
    @EnvironmentObject private var coordinator: NavigationCoordinator
    @EnvironmentObject private var settings: SettingsViewModel
    @State private var notificationStatus: UNAuthorizationStatus = .notDetermined
    
    var body: some View {
        VStack {
            // Тоггл с напоминаниями
            Toggle(isOn: $isReminderEnabled) {
                Text("Reminder to read affirmations")
                    .font(.caption)
                    .foregroundColor(.white)
            }
            .tint(.brown)
            .disabled(notificationStatus == .denied)
            .padding(.horizontal)
            .onChange(of: isReminderEnabled) { isOn in
                settings.updateReminders()
                if isOn {
                    coordinator.present(.reminderPicker(type: ReminderType.affirmation))
                }
            }
            
            if isReminderEnabled {
                HStack {
                    Button("Notification settings") {
                        coordinator.present(.reminderPicker(type: ReminderType.affirmation))
                    }
                    .font(.caption)
                    .foregroundColor(.brown)
                    .padding(.horizontal)
                    .padding(.vertical, 4)
                    
                    Spacer()
                }
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
        .padding(.vertical, 8)
        .background(Color.white.opacity(0.1))
        .cornerRadius(radius: 10, corners: .allCorners)
        .padding(.horizontal)
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
    ZStack {
        BackgroundView()
        
        ReminderToggleView(isReminderEnabled: .constant(true))
    }
    .preferredColorScheme(.dark)
}
