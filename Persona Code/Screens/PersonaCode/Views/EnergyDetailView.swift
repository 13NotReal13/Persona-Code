//
//  ArkanDetailView.swift
//  Persona Code
//
//  Created by Иван Семикин on 24/02/2025.
//

import SwiftUI

struct EnergyDetailView: View {
    @State var energyInfo: EnergyInfo
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(energyInfo.title)
                .font(.system(size: 21))
                .bold()
            
            ForEach(energyInfo.subcategories, id: \.self) { subcategorie in
                Text(subcategorie.title)
                    .font(.title3)
                    .bold()
                    .padding(.top)
                Text(subcategorie.shortDescription)
                    .opacity(0.7)
                Text(subcategorie.mainDescription)
            }
        }
        .foregroundStyle(.white)
    }
}

#Preview {
    ZStack {
        BackgroundView()
        
        EnergyDetailView(energyInfo: DestinyNumberEnergies.allEnergies[1]!)
    }
}
