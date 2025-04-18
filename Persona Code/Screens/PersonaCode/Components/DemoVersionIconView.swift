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
                        .fill(Color.brown)
                        .brightness(-0.3)
                    
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(style: StrokeStyle(lineWidth: 2))
                        .foregroundStyle(.brown)
                }
            )
    }
}

#Preview {
    DemoVersionIconView(fontSize: CGFloat(17))
        .preferredColorScheme(.dark)
}
