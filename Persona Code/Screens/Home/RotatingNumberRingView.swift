//
//  RotatingNumberRingView.swift
//  Persona Code
//
//  Created by Иван Семикин on 22/02/2025.
//

import SwiftUI

enum Direction {
    case left
    case right
}

struct RotatingNumberRingView: View {
    var sizeOfRing: CGFloat
    var fontSize: CGFloat
    var direction: Direction
    
    @State private var angleOffset: Double = 0
    
    private let numbers = Array(1...22)
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { geometry in
            let size = min(geometry.size.width, geometry.size.height) * sizeOfRing
            let radius = size / 2
            
            ZStack {
                ForEach(0..<numbers.count, id: \.self) { index in
                    let angle = (Double(index) * 360.0 / 22) + angleOffset
                    let x = cos(angle * .pi / 180) * radius
                    let y = sin(angle * .pi / 180) * radius
                    
                    Text("\(numbers[index])")
                        .font(.system(size: fontSize))
                        .foregroundStyle(.black)
                        .position(x: geometry.size.width / 2 + x, y: geometry.size.height / 2 + y)
                }
            }
            .onReceive(timer) { _ in
                withAnimation(.easeInOut(duration: 0.5)) {
                    switch direction {
                    case .left:
                        angleOffset -= 360 / 22
                    case .right:
                        angleOffset += 360 / 22
                    }
                }
            }
        }
        .background(Color.clear.ignoresSafeArea())
    }
}

#Preview {
    RotatingNumberRingView(
        sizeOfRing: CGFloat(0.8),
        fontSize: CGFloat(21),
        direction: Direction.left
    )
}
