//
//  DescriptionPurchaseView.swift
//  Persona Code
//
//  Created by Иван Семикин on 25/02/2025.
//

import SwiftUI

struct DescriptionPurchaseView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Что вы получите:")
                .customText(fontSize: 15)
                .padding(.leading, 6)
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                    
                    PurchaseFeatureView(
                        title: "Персональный разбор",
                        description: "Глубокий анализ вашего Кода Личности на основе имени и даты рождения."
                    )
                }
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                    
                    PurchaseFeatureView(
                        title: "12 аспектов личности",
                        description: "Включает ключевые сферы: самореализацию, карьеру, отношения, финансы, сильные стороны и многое другое."
                    )
                }
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                    
                    PurchaseFeatureView(
                        title: "Практические рекомендации",
                        description: "Советы и стратегии для гармоничного развития, раскрытия потенциала и достижения целей."
                    )
                }
                HStack {
                    Image(systemName: "square.and.arrow.down.fill")
                        .foregroundStyle(.green)
                    
                    PurchaseFeatureView(
                        title: "Персональный PDF-отчёт",
                        description: "Скачивайте полный разбор вашего Кода Личности в удобном формате."
                    )
                }
            }
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.cyan, lineWidth: 1)
            }
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
        .padding(.horizontal)
    }
}

#Preview {
    DescriptionPurchaseView()
        .preferredColorScheme(.dark)
}
