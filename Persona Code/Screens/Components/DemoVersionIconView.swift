//
//  DemoVersionIconView.swift
//  Persona Code
//
//  Created by Иван Семикин on 13/04/2025.
//

import SwiftUI

struct DemoVersionIconView: View {
    let fontSize: CGFloat
    
    var body: some View {
        Text("Demo Version")
            .customText(fontSize: fontSize, customFont: .interDisplaySemiBold)
            .padding(.vertical, 4)
            .padding(.horizontal, 12)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.gray.opacity(0.4))
                    
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(style: StrokeStyle(lineWidth: 2))
                        .foregroundStyle(.gray)
                        .brightness(0.1)
                        .opacity(0.7)
                }
            )
    }
}

#Preview {
    DemoVersionIconView(fontSize: CGFloat(17))
        .preferredColorScheme(.dark)
}
