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
                .font(.title2)
                .bold()
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
            
            ForEach(codeInfo.subcategories, id: \.self) { subcategorie in
                Text(subcategorie.title)
                    .font(.headline)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .center)
                Text(subcategorie.shortDescription)
                    .opacity(0.8)
                    .fixedSize(horizontal: false, vertical: true)
                Text(subcategorie.mainDescription)
            }
        }
        .foregroundStyle(.white)
    }
}

#Preview {
    ZStack {
        BackgroundView()
        
        CodeDetailView(codeInfo: PersonaCodeCodes_RU.allCodes[1]!)
    }
}
