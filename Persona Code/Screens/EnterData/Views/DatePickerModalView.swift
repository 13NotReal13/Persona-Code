//
//  DatePickerModalView.swift
//  Persona Code
//
//  Created by Иван Семикин on 23/02/2025.
//

import SwiftUI

struct DatePickerModalView: View {
    @ObservedObject var enterDataViewModel: EnterDataViewModel
    
    var body: some View {
        ZStack {
            BackgroundView(isAnimated: false)
            
            ShadowBackgroundView()
            
            VStack {
                Spacer()
                
                // Выбор даты
                DatePicker("Birth date", selection: $enterDataViewModel.dateBirthday, displayedComponents: .date)
                    .datePickerStyle(.wheel)
                    .colorInvert()
                    .colorMultiply(Color.white)
                    .labelsHidden()
                    .padding()
                    .onChange(of: enterDataViewModel.dateBirthday) { _ in
                        enterDataViewModel.updateDisplayedDate()
                    }
                
                // Кнопка закрытия
                Button {
                    enterDataViewModel.isDatePickerPresented = false
                } label: {
                    Text("Done")
                        .customText(fontSize: 16)
                        .customButtonStyle(
                            width: UIScreen.main.bounds.width * 0.4,
                            shape: .capsule
                        )
                }
            }
            .padding()
        }
    }
}

#Preview {
    DatePickerModalView(enterDataViewModel: EnterDataViewModel())
}
