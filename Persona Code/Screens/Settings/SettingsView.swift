//
//  SettingsView.swift
//  Persona Code
//
//  Created by Иван Семикин on 03/03/2025.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var coordinator: NavigationCoordinator
    @StateObject private var affirmationViewModel = AffirmationsViewModel.shared
    
    var body: some View {
        ZStack {
            BackgroundView(isAnimated: false)
            ShadowBackgroundView()
            
            VStack {
                VStack {
                    Toggle(isOn: $affirmationViewModel.isReminderEnabled) {
                        Text("Ежедневные PUSH пожелания")
                            .font(.caption)
                            .foregroundStyle(.white)
                    }
                    .tint(.brown)
                    .padding(.horizontal)
                    .onChange(of: affirmationViewModel.isReminderEnabled) { _ in
                        affirmationViewModel.updateReminders()
                    }
                }
                .padding(.vertical)
                .background(.white.opacity(0.1))
                .cornerRadius(radius: 10, corners: .allCorners)
                .padding(.horizontal)
                
                VStack {
                    Toggle(isOn: $affirmationViewModel.isReminderEnabled) {
                        Text("Напоминание прочитать аффирмации")
                            .font(.caption)
                            .foregroundStyle(.white)
                    }
                    .tint(.brown)
                    .padding(.horizontal)
                    .onChange(of: affirmationViewModel.isReminderEnabled) { _ in
                        affirmationViewModel.updateReminders()
                    }
                    
                    // Выбор дней недели
                    if affirmationViewModel.isReminderEnabled {
                        HStack {
                            ForEach(1...7, id: \.self) { day in
                                Button {
                                    affirmationViewModel.toggleDaySelection(day)
                                } label: {
                                    Text(affirmationViewModel.weekDays[day - 1])
                                        .padding(8)
                                        .background(
                                            affirmationViewModel.selectedDays.contains(day)
                                            ? Color.brown
                                            : .gray.opacity(0.5)
                                        )
                                        .cornerRadius(radius: 5, corners: .allCorners)
                                        .foregroundStyle(.white)
                                }
                            }
                        }
                        .padding(.horizontal)
                        
                        DatePicker(
                            "Время напоминания",
                            selection: $affirmationViewModel.reminderDate,
                            displayedComponents: .hourAndMinute
                        )
                        .datePickerStyle(.wheel)
                        .labelsHidden()
                        .onChange(of: affirmationViewModel.reminderTime) { _ in
                            affirmationViewModel.updateReminders()
                        }
                        
                    }
                }
                .padding(.vertical)
                .background(.white.opacity(0.1))
                .cornerRadius(radius: 10, corners: .allCorners)
                .padding(.horizontal)
                
                Spacer()
            }
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
