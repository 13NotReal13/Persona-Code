//
//  ButtonLabelView.swift
//  Persona Code
//
//  Created by Иван Семикин on 20/04/2025.
//

import SwiftUI

struct ButtonLabelView: View {
    let text: String
    let fontSize: CGFloat
    let widthMultiplyBy: CGFloat
    
    @AppStorage("currentLanguage") var currentLanguage: String = "en"
    
    var body: some View {
        ZStack {
            Text(localizedString(text))
                .opacity(0.8)
                .shadow(color: .black.opacity(0.3), radius: 3, x: 3, y: 3)
                .customText(fontSize: fontSize, customFont: .interDisplaySemiBold)
                .padding()
                .frame(width: UIScreen.main.bounds.width * widthMultiplyBy)
                .background {
                    ZStack {
                        Capsule()
                            .foregroundStyle(.ringColor2.opacity(0.4))
                            .clipShape(.capsule)
                        
                        Capsule()
                            .stroke(lineWidth: 2)
                            .shadow(color: .white, radius: 3, x: 3, y: 3)
                            .foregroundStyle(.white.opacity(0.4))
                            .clipShape(.capsule)
                            .shadow(color: .black, radius: 3, x: 3, y: 3)
                    }
                }
        }
    }
}

#Preview {
    ZStack {
        BackgroundView()
        
        ButtonLabelView(
            text: "Persona Code",
            fontSize: 17,
            widthMultiplyBy: 0.8
        )
    }
    .ignoresSafeArea()
}
