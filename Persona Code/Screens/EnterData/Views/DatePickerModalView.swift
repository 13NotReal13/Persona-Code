//
//  DatePickerModalView.swift
//  Persona Code
//
//  Created by Иван Семикин on 23/02/2025.
//

import SwiftUI

struct DatePickerModalView: View {
    @EnvironmentObject private var coordinator: NavigationCoordinator
    @ObservedObject var enterDataViewModel: EnterDataViewModel
    
    var body: some View {
        VStack {
            // Выбор даты
            DatePicker("Birth date", selection: $enterDataViewModel.dateBirthday, displayedComponents: .date)
                .datePickerStyle(.wheel)
                .labelsHidden()
                .padding()
                .onChange(of: enterDataViewModel.dateBirthday) { _ in
                    enterDataViewModel.updateDisplayedDate()
                }
            
            Button {
                coordinator.dismissModal()
            } label: {
                Text("Save")
                    .customText(fontSize: 16)
                    .customButtonStyle(
                        width: UIScreen.main.bounds.width * 0.4,
                        shape: .capsule
                    )
            }
        }
    }
}

#Preview {
    DatePickerModalView(enterDataViewModel: EnterDataViewModel())
}
