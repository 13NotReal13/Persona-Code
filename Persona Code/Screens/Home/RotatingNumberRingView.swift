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
    var colorOfCircle: Color
    
    @State private var angleOffset: Double = 10
    
    private let numbers = Array(1...22)
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { geometry in
            let size = min(geometry.size.width, geometry.size.height) * sizeOfRing
            let radius = size / 2
            
            ZStack {
                Circle()
                    .foregroundStyle(colorOfCircle)
                    .frame(width: geometry.size.width * (sizeOfRing + 0.08))
                    .overlay {
                        Circle()
                            .stroke(lineWidth: 1)
                            .foregroundStyle(.white)
                    }
                
                ForEach(0..<numbers.count, id: \.self) { index in
                    let angle = (Double(index) * 360.0 / 22) + angleOffset
                    let x = cos(angle * .pi / 180) * radius
                    let y = sin(angle * .pi / 180) * radius
                    
                    Text("\(numbers[index])")
                        .font(.system(size: fontSize))
                        .bold()
                        .foregroundStyle(.white)
                        .position(x: geometry.size.width / 2 + x, y: geometry.size.height / 2 + y)
                }
            }
            .shadow(color: .white, radius: 10)
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
    ZStack {
        RotatingNumberRingView(
            sizeOfRing: 0.6,
            fontSize: 17,
            direction: .left,
            colorOfCircle: Color.ringColor1
        )
            .offset(y: -120)
        
        RotatingNumberRingView(
            sizeOfRing: 0.45,
            fontSize: 15,
            direction: .right,
            colorOfCircle: Color.ringColor2
        )
            .offset(y: -120)
        
        RotatingNumberRingView(
            sizeOfRing: 0.3,
            fontSize: 13,
            direction: .left,
            colorOfCircle: Color.ringColor1
        )
            .offset(y: -120)
    }
    .background(Color.black)
}
