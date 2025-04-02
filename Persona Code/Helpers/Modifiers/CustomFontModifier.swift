//
//  CustomShadowModifier.swift
//  Persona Code
//
//  Created by Иван Семикин on 23/02/2025.
//

import Foundation
import SwiftUI

struct CustomFontModifier: ViewModifier {
    var fontSize: CGFloat
    var customFont: CustomFont
    
    func body(content: Content) -> some View {
        content
            .font(.custom(customFont.rawValue, size: fontSize))
            .foregroundStyle(.white)
    }
}
