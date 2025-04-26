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
                Text("Demo Version")
                    .frame(maxWidth: .infinity)
                    .frame(alignment: .center)
                    .customText(fontSize: 21, customFont: .interDisplaySemiBold)
                
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.gray)
                    
                    PurchaseFeatureView(
                        title: localizedString("Limited Analysis"),
                        description: localizedString("A limited calculation and analysis of your Persona Code.")
                    )
                }

                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.gray)
                    
                    PurchaseFeatureView(
                        title: localizedString("3 Personality Aspects"),
                        description: localizedString("3 out of 12 aspects, including Persona Code, Growth Path, and Communication.")
                    )
                }
            }
            .fixedSize(horizontal: false, vertical: true)
            .padding()
        }
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(style: StrokeStyle(lineWidth: selectedPlan == .demo ? 2 : 1))
                .foregroundColor(selectedPlan == .demo ? .white.opacity(0.7) : .gray.opacity(0.4))
        }
        .padding(.horizontal)
    }
}

#Preview {
    DemoPLanView(selectedPlan: .constant(PlanType.demo))
        .preferredColorScheme(.dark)
}
