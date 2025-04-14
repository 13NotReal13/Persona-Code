//
//  FullVersionIconView.swift
//  Persona Code
//
//  Created by Иван Семикин on 13/04/2025.
//

import SwiftUI

struct FullVersionIconView: View {
    let fontSize: CGFloat
    
    var body: some View {
        Text("Full Version")
            .customText(fontSize: fontSize, customFont: .interDisplaySemiBold)
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(OutlineGradientButtonBackgroundView())
    }
}

#Preview {
    FullVersionIconView(fontSize: CGFloat(17))
}
