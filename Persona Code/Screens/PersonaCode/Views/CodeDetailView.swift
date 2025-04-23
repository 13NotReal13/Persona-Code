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
                .customText(fontSize: 22)
                .bold()
                .opacity(0.9)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
            
            ForEach(codeInfo.subcategories, id: \.self) { subcategorie in
                Text(subcategorie.title)
                    .customText(fontSize: 17)
                    .bold()
                    .opacity(0.9)
                    .frame(maxWidth: .infinity, alignment: .center)
                Text(subcategorie.shortDescription)
                    .customText(fontSize: 17)
                    .opacity(0.7)
                    .fixedSize(horizontal: false, vertical: true)
                Text(subcategorie.mainDescription)
                    .customText(fontSize: 17)
                    .opacity(0.9)
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
