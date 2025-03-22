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
            Text("Enter your full name (first name only)")
                .customText(fontSize: 12)
            
            ZStack {
                Color.clear
                    .frame(height: UIScreen.main.bounds.height * 0.02)
                    .customButtonStyle(width: UIScreen.main.bounds.width * 0.7, shape: .capsule)
                    .opacity(0.7)
                
                TextField(
                    "",
                    text: $name,
                    prompt: Text("FULL NAME")
                        .foregroundColor(Color.white.opacity(0.65))
                )
                .frame(width: UIScreen.main.bounds.width * 0.7)
                .padding(.vertical, 8)
                .textContentType(.givenName)
                .disableAutocorrection(true)
                .multilineTextAlignment(.center)
                .submitLabel(.done)
                .customText(fontSize: 16)
                .onChange(of: name) { newValue in
                    name = newValue.replacingOccurrences(of: " ", with: "")
                }
            }
            
            VStack {
                if !isNameValid {
                    Text("The name can only contain letters")
                        .font(.custom(CustomFont.correctionBrush.rawValue, size: 12))
                        .foregroundStyle(.red)
                }
            }
            .frame(height: UIScreen.main.bounds.height * 0.01)
        }
    }
}
