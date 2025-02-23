//
//  CustomButtonStyleModifier.swift
//  Persona Code
//
//  Created by Иван Семикин on 23/02/2025.
//

import SwiftUI

enum TypeShape {
    case capsule
    case circle
}

struct CustomButtonStyleModifier: ViewModifier {
    var color1: Color
    var color2: Color
    var width: CGFloat
    var shape: TypeShape

    func body(content: Content) -> some View {
        content
            .frame(width: width)
            .padding()
            .padding(.horizontal, 8)
            .background(
                LinearGradient(
                    stops: [
                        .init(color: color2, location: 0),
                        .init(color: color1, location: 1)
                    ],
                    startPoint: .bottom,
                    endPoint: .top
                )
            )
            .overlay(
                Group {
                    if shape == .capsule {
                        Capsule().stroke(Color.white, lineWidth: 1)
                    } else {
                        Circle().stroke(Color.white, lineWidth: 1)
                    }
                }
            )
            .modifier(ConditionalClipShape(shape: shape))
    }
}

struct ConditionalClipShape: ViewModifier {
    var shape: TypeShape

    func body(content: Content) -> some View {
        if shape == .capsule {
            content.clipShape(Capsule())
        } else {
            content.clipShape(Circle())
        }
    }
}
