//
//  FullPlanView.swift
//  Persona Code
//
//  Created by Иван Семикин on 07/04/2025.
//

import SwiftUI

struct FullPlanView: View {
    @Binding var selectedPlan: PlanType
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("Full Version")
                    .frame(maxWidth: .infinity)
                    .frame(alignment: .center)
                    .customText(fontSize: 21, customFont: .interDisplaySemiBold)
                
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.mint)
                    
                    PurchaseFeatureView(
                        title: localizedString("Personal analysis"),
                        description: localizedString("Individual calculation and in-depth analysis of your Persona Code.")
                    )
                }
                
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.mint)
                    
                    PurchaseFeatureView(
                        title: localizedString("12 aspects of personality"),
                        description: localizedString("Includes key areas: self-realization, career, relationships, finances, strengths, and much more.")
                    )
                }
                
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.mint)
                    
                    PurchaseFeatureView(
                        title: localizedString("Practical recommendations"),
                        description: localizedString("Tips and strategies for harmonious development, unlocking potential, and achieving goals.")
                    )
                }
                
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.mint)
                    
                    PurchaseFeatureView(
                        title: localizedString("Personal PDF report"),
                        description: localizedString("Download the complete analysis of your Persona Code in a convenient format.")
                    )
                }
            }
            .fixedSize(horizontal: false, vertical: true)
            .padding()
        }
        .background(
            Group {
                if selectedPlan == .demo {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(style: StrokeStyle(lineWidth: 1))
                        .foregroundStyle(.gray.opacity(0.4))
                } else {
                    OutlineGradientButtonBackgroundView()
                }
            }
        )
        .padding(.horizontal)
    }
}

#Preview {
    FullPlanView(selectedPlan: .constant(PlanType.full))
        .preferredColorScheme(.dark)
}
