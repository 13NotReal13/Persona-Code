//
//  NameTextFieldView.swift
//  Persona Code
//
//  Created by Иван Семикин on 23/02/2025.
//

import SwiftUI

struct NameTextFieldView: View {
    @Binding var name: String
    @Binding var isNameValid: Bool
    
    var validateName: () -> Void
    
    var body: some View {
        VStack {
            Text("Введите ваше полное имя (только имя)")
                .customText(fontSize: 12)
            
            ZStack {
                Color.clear
                    .frame(height: UIScreen.main.bounds.height * 0.02)
                    .customButtonStyle(width: UIScreen.main.bounds.width * 0.7, shape: .capsule)
                    .opacity(0.7)
                
                TextField(
                    "",
                    text: $name,
                    prompt: Text("ПОЛНОЕ ИМЯ")
                        .foregroundColor(Color.white.opacity(0.65))
                )
                .textContentType(.none)
                .disableAutocorrection(true)
                .multilineTextAlignment(.center)
                .customText(fontSize: 16)
                .onChange(of: name) { newValue in
                    name = newValue.replacingOccurrences(of: " ", with: "")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        validateName()
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width * 0.7)
            
            VStack {
                if !isNameValid {
                    Text("Допустимые символы: \"А-Я\"")
                        .font(.custom("CorrectionBrush", size: 12))
                        .foregroundStyle(.red)
                }
            }
            .frame(height: UIScreen.main.bounds.height * 0.01)
        }
    }
}
