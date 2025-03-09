//
//  DatePickerView.swift
//  Persona Code
//
//  Created by Иван Семикин on 23/02/2025.
//

import SwiftUI

struct DatePickerView: View {
    @Binding var isDatePickerPresented: Bool
    @Binding var displayedDateText: String
    @Binding var isDateValid: Bool
    
    var body: some View {
        VStack {
            Text("Select your birth date")
                .customText(fontSize: 12)
            
            Button(action: {
                UIApplication.shared.connectedScenes
                    .compactMap { ($0 as? UIWindowScene)?.keyWindow }
                    .first?
                    .endEditing(true)
                isDatePickerPresented.toggle()
            }) {
                ZStack {
                    Color.clear
                        .frame(height: UIScreen.main.bounds.height * 0.02)
                        .customButtonStyle(width: UIScreen.main.bounds.width * 0.7, shape: .capsule)
                        .opacity(0.7)
                    
                    HStack {
                        if displayedDateText.lowercased() == "Choose a date".lowercased() {
                            Text(displayedDateText)
                                .font(.custom(CustomFont.correctionBrush.rawValue, size: 16))
                                .foregroundStyle(Color.white.opacity(0.6))
                        } else {
                            Text(displayedDateText)
                                .customText(fontSize: 16)
                        }
                    }
                }
                .frame(width: UIScreen.main.bounds.width * 0.7)
            }
            
            VStack {
                if !isDateValid {
                    Text("Choose a date")
                        .font(.custom(CustomFont.correctionBrush.rawValue, size: 12))
                        .foregroundStyle(.red)
                }
            }
            .frame(height: UIScreen.main.bounds.height * 0.01)
        }
    }
}
