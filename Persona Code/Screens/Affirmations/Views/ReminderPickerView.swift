//
//  ReminderPickerView.swift
//  Persona Code
//
//  Created by Иван Семикин on 03/03/2025.
//

import SwiftUI

enum ReminderType {
    case affirmation
    case wish
}

struct ReminderPickerView: View {
    @EnvironmentObject private var coordinator: NavigationCoordinator
    @EnvironmentObject private var viewModel: SettingsViewModel
    
    let reminderType: ReminderType
    
    var body: some View {
        VStack(spacing: 20) {
            Text(reminderType == .affirmation ? "Напоминания об аффирмациях" : "Ежедневные вдохновения")
                .font(.headline)
                .padding(.top)
            
            if (reminderType == .affirmation && viewModel.isReminderEnabled) ||
               (reminderType == .wish && viewModel.isWishNotificationEnabled) {
                
                // Выбор дней недели
                HStack {
                    ForEach(1...7, id: \.self) { day in
                        Button {
                            viewModel.toggleDaySelection(day, for: reminderType)
                        } label: {
                            Text(viewModel.weekDays[day - 1])
                                .padding(8)
                                .background(
                                    viewModel.selectedDays(for: reminderType).contains(day)
                                    ? Color.brown
                                    : .gray.opacity(0.5)
                                )
                                .cornerRadius(5)
                                .foregroundColor(.white)
                        }
                    }
                }
                .padding(.horizontal)
                
                // Выбор времени
                DatePicker(
                    "Время напоминания",
                    selection: reminderType == .affirmation ? $viewModel.reminderDate : $viewModel.wishDate,
                    displayedComponents: .hourAndMinute
                )
                .datePickerStyle(.wheel)
                .labelsHidden()
                .padding(.horizontal)
            }
            
            Button("Сохранить") {
                if reminderType == .affirmation {
                    viewModel.updateReminders()
                } else {
                    viewModel.updateWishNotifications()
                }
                coordinator.dismissModal()
            }
            .customText(fontSize: 17)
            .customButtonStyle(
                width: UIScreen.main.bounds.width * 0.4,
                shape: .capsule
            )
        }
        .background(Color.clear)
        .onAppear {
            if reminderType == .affirmation {
                viewModel.updateReminders()
            } else {
                viewModel.updateWishNotifications()
            }
        }
    }
}

#Preview {
    ZStack {
        BackgroundView(isAnimated: false)
        ShadowBackgroundView(isHighShadowLevel: true)
        
        ReminderPickerView(reminderType: ReminderType.affirmation)
            .preferredColorScheme(.dark)
            .environmentObject(NavigationCoordinator())
            .environmentObject(AffirmationsViewModel.shared)
    }
}
