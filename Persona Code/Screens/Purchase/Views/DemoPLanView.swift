//
//  DemoPLanView.swift
//  Persona Code
//
//  Created by Иван Семикин on 07/04/2025.
//

import SwiftUI

struct DemoPLanView: View {
    @Binding var selectedPlan: PlanType
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("Демо версия")
                    .frame(maxWidth: .infinity)
                    .frame(alignment: .center)
                    .customText(fontSize: 21, customFont: .interDisplaySemiBold)
                
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
                
                Spacer()
            }
            .fixedSize(horizontal: false, vertical: true)
            .padding()
        }
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(style: StrokeStyle(lineWidth: selectedPlan == .demo ? 2 : 1))
                .foregroundColor(selectedPlan == .demo ? .green : .gray.opacity(0.4))
        }
        .padding(.horizontal)
    }
}

#Preview {
    DemoPLanView(selectedPlan: .constant(PlanType.demo))
        .preferredColorScheme(.dark)
}
