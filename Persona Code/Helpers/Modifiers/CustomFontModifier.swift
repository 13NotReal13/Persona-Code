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
    
    func body(content: Content) -> some View {
        content
            .font(.custom(CustomFont.correctionBrush.rawValue, size: fontSize))
            .foregroundStyle(.white)
    }
}
