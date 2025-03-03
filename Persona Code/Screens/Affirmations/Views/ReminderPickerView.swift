//
//  ReminderPickerView.swift
//  Persona Code
//
//  Created by Иван Семикин on 03/03/2025.
//

import SwiftUI

struct ReminderPickerView: View {
    @EnvironmentObject private var coordinator: NavigationCoordinator
    @EnvironmentObject private var viewModel: AffirmationsViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Настройки напоминаний")
                .font(.headline)
                .padding(.top)
            
            if viewModel.isReminderEnabled {
                // Выбор дней недели
                HStack {
                    ForEach(1...7, id: \.self) { day in
                        Button {
                            viewModel.toggleDaySelection(day)
                        } label: {
                            Text(viewModel.weekDays[day - 1])
                                .padding(8)
                                .background(
                                    viewModel.selectedDays.contains(day)
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
                    selection: $viewModel.reminderDate,
                    displayedComponents: .hourAndMinute
                )
                .datePickerStyle(.wheel)
                .labelsHidden()
                .padding(.horizontal)
            }
            
            Button("Сохранить") {
                viewModel.updateReminders()
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
            viewModel.updateReminders()
        }
    }
}

#Preview {
    ZStack {
        BackgroundView(isAnimated: false)
        ShadowBackgroundView(isHighShadowLevel: true)
        
        ReminderPickerView()
            .preferredColorScheme(.dark)
            .environmentObject(NavigationCoordinator())
            .environmentObject(AffirmationsViewModel.shared)
    }
}
