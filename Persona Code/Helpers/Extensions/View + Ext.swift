//
//  View + Ext.swift
//  Persona Code
//
//  Created by Иван Семикин on 23/02/2025.
//

import Foundation
import SwiftUI

extension View {
    func customText(fontSize: CGFloat) -> some View {
        self.modifier(CustomFontModifier(fontSize: fontSize))
    }
    
    func customButtonStyle(
        color1: Color = .ringColor1,
        color2: Color = .ringColor2,
        width: CGFloat,
        shape: TypeShape
    ) -> some View {
        self.modifier(CustomButtonStyleModifier(color1: color1, color2: color2, width: width, shape: shape))
    }
    
    func cornerRadius(radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorners(radius: radius, corners: corners) )
    }
}

struct RoundedCorners: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
