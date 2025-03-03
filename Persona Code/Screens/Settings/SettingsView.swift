//
//  SettingsView.swift
//  Persona Code
//
//  Created by Иван Семикин on 03/03/2025.
//

//import SwiftUI
//
//struct SettingsView: View {
//    var body: some View {
//        Toggle(isOn: $viewModel.isReminderEnabled) {
//            Text("Напоминание прочитать аффирмации")
//                .font(.caption)
//                .foregroundStyle(.white)
//        }
//        .tint(.brown)
//        .padding(.horizontal)
//        .onChange(of: viewModel.isReminderEnabled) { _ in
//            viewModel.updateReminders()
//        }
//        
//        // Выбор дней недели
//        if viewModel.isReminderEnabled {
//            HStack {
//                ForEach(1...7, id: \.self) { day in
//                    Button {
//                        viewModel.toggleDaySelection(day)
//                    } label: {
//                        Text(viewModel.weekDays[day - 1])
//                            .padding(8)
//                            .background(
//                                viewModel.selectedDays.contains(day)
//                                ? Color.brown
//                                    : .gray.opacity(0.5)
//                            )
//                            .cornerRadius(radius: 5, corners: .allCorners)
//                            .foregroundStyle(.white)
//                    }
//                }
//            }
//            .padding(.horizontal)
//            
//            DatePicker(
//                "Время напоминания",
//                selection: $viewModel.reminderTime,
//                displayedComponents: .hourAndMinute
//            )
//            .datePickerStyle(.wheel)
//            .labelsHidden()
//            .onChange(of: viewModel.reminderTime) { _ in
//                viewModel.updateReminders()
//            }
//        }
//    }
//}
//
//#Preview {
//    SettingsView()
//}
