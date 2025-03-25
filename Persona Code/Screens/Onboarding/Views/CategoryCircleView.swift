//
//  CategoryCircleView.swift
//  Persona Code
//
//  Created by Иван Семикин on 25/03/2025.
//

import SwiftUI

struct CategoryCircleView: View {
    let icons = [
        "person.crop.circle",         // 1. Код Личности
        "figure.walk",                // 2. Путь Развития
        "message",                    // 3. Коммуникация
        "creditcard",                 // 4. Финансовый Потенциал
        "briefcase",                  // 5. Профессиональный Рост
        "bolt.heart",                 // 6. Ресурсное Состояние
        "star.fill",                  // 7. Сильные Стороны
        "exclamationmark.triangle",  // 8. Зоны Риска
        "book.closed",               // 9. Саморазвитие
        "brain.head.profile",        // 10. Внутренний Баланс
        "target",                    // 11. Жизненные Цели
        "clock.arrow.circlepath"     // 12. Опыт и Эволюция
    ]
    
    var body: some View {
        GeometryReader { geo in
            let size = min(geo.size.width, geo.size.height)
            let radius = size * 0.4
            let center = CGPoint(x: geo.size.width / 2, y: geo.size.height / 2)
            let startOffset: CGFloat = radius * 0.4 // насколько ближе к центру начало линии
            let endOffset: CGFloat = radius * 0.25  // насколько не доходит до иконки

            ZStack {
                // Линии от центра к иконкам
                ForEach(0..<icons.count, id: \.self) { i in
                    let angle = Angle(degrees: Double(i) / Double(icons.count) * 360)
                    let dx = cos(angle.radians)
                    let dy = sin(angle.radians)

                    let start = CGPoint(
                        x: center.x + dx * startOffset,
                        y: center.y + dy * startOffset
                    )

                    let end = CGPoint(
                        x: center.x + dx * (radius - endOffset),
                        y: center.y + dy * (radius - endOffset)
                    )

                    Path { path in
                        path.move(to: start)
                        path.addLine(to: end)
                    }
                    .stroke(Color.white.opacity(0.3), lineWidth: 1)
                }

                // Иконки по кругу
                ForEach(0..<icons.count, id: \.self) { i in
                    let angle = Angle(degrees: Double(i) / Double(icons.count) * 360)
                    let x = center.x + cos(angle.radians) * radius
                    let y = center.y + sin(angle.radians) * radius

                    Image(systemName: icons[i])
                        .resizable()
                        .scaledToFit()
                        .frame(width: 36, height: 36)
                        .foregroundColor(.ringColor1)
                        .position(x: x, y: y)
                }
            }
        }
    }
}

#Preview {
    CategoryCircleView()
        .background(BackgroundView(shadowLevel: .high))
        .preferredColorScheme(.dark)
}
