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
            Text("What you will get:")
                .customText(fontSize: 15)
                .padding(.leading, 6)
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                    
                    PurchaseFeatureView(
                        title: localizedString("Personal analysis"),
                        description: localizedString("Individual calculation and in-depth analysis of your Persona Code.")
                    )
                }
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                    
                    PurchaseFeatureView(
                        title: localizedString("12 aspects of personality"),
                        description: localizedString("Includes key areas: self-realization, career, relationships, finances, strengths, and much more.")
                    )
                }
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                    
                    PurchaseFeatureView(
                        title: localizedString("Practical recommendations"),
                        description: localizedString("Tips and strategies for harmonious development, unlocking potential, and achieving goals.")
                    )
                }
                HStack {
                    Image(systemName: "square.and.arrow.down.fill")
                        .foregroundStyle(.green)
                    
                    PurchaseFeatureView(
                        title: localizedString("Personal PDF report"),
                        description: localizedString("Download the complete analysis of your Persona Code in a convenient format.")
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
    }
}

#Preview {
    DescriptionPurchaseView()
        .preferredColorScheme(.dark)
}
