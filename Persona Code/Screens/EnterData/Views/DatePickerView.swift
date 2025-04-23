//
//  DatePickerView.swift
//  Persona Code
//
//  Created by Иван Семикин on 23/02/2025.
//

import SwiftUI

struct DatePickerView: View {
    @EnvironmentObject private var coordinator: NavigationCoordinator
    @ObservedObject var enterDataViewModel: EnterDataViewModel
    
    var body: some View {
        VStack {
            Text("Select your birth date")
                .customText(fontSize: 12)
            
            Button {
                UIApplication.shared.sendAction(
                    #selector(UIResponder.resignFirstResponder),
                    to: nil,
                    from: nil,
                    for: nil
                )
                coordinator.enterDataViewModel = enterDataViewModel
                coordinator.present(.datePicker)
            } label: {
                ZStack {
                    Color.clear
                        .frame(height: UIScreen.main.bounds.height * 0.02)
                        .customButtonStyle(width: UIScreen.main.bounds.width * 0.7, shape: .capsule)
                        .opacity(0.7)
                    
                    HStack {
                        if enterDataViewModel.displayedDateText.lowercased() == localizedString("Choose a Date").lowercased() {
                            Text(enterDataViewModel.displayedDateText)
                                .font(.custom(CustomFont.interVariable.rawValue, size: 16))
                                .foregroundStyle(Color.white.opacity(0.5))
                        } else {
                            Text(enterDataViewModel.displayedDateText)
                                .customText(fontSize: 16)
                        }
                    }
                }
                .frame(width: UIScreen.main.bounds.width * 0.7)
            }
            
            VStack {
                if !enterDataViewModel.isDateValid {
                    Text("Date selection required")
                        .font(.custom(CustomFont.interVariable.rawValue, size: 12))
                        .foregroundStyle(.red)
                }
            }
            .frame(height: UIScreen.main.bounds.height * 0.01)
        }
    }
}
