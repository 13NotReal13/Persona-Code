//
//  CodeDetailView.swift
//  Persona Code
//
//  Created by Иван Семикин on 24/02/2025.
//

import SwiftUI

struct CodeDetailView: View {
    @State var codeInfo: CodeInfo
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(codeInfo.title)
                .font(.system(size: 21))
                .bold()
            
            ForEach(codeInfo.subcategories, id: \.self) { subcategorie in
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
        
        CodeDetailView(codeInfo: DestinyNumberEnergies.allCodes[1]!)
    }
}
