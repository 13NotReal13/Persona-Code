//
//  ReminderToggleView.swift
//  Persona Code
//
//  Created by Иван Семикин on 04/03/2025.
//

import SwiftUI

struct ReminderToggleView: View {
    @EnvironmentObject private var coordinator: NavigationCoordinator
    @Binding var isReminderEnabled: Bool
    
    var body: some View {
        VStack {
            // Тоггл с напоминаниями
            Toggle(isOn: $isReminderEnabled) {
                Text("Напоминание прочитать аффирмации")
                    .font(.caption)
                    .foregroundColor(.white)
            }
            .tint(.brown)
            .padding(.horizontal)
            .onChange(of: isReminderEnabled) { isOn in
                if isOn {
                    coordinator.present(.reminderPicker(type: ReminderType.affirmation))
                } else {
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                }
            }
            
            if isReminderEnabled {
                HStack {
                    Button("Настройки уведомлений") {
                        coordinator.present(.reminderPicker(type: ReminderType.affirmation))
                    }
                    .font(.caption)
                    .foregroundColor(.brown)
                    .padding(.horizontal)
                    
                    Spacer()
                }
            }
        }
        .padding(.vertical, 8)
        .background(Color.white.opacity(0.1))
        .cornerRadius(radius: 10, corners: .allCorners)
        .padding(.horizontal)
    }
}

//#Preview {
//    ReminderButtonView(isReminderEnabled: true)
//}
