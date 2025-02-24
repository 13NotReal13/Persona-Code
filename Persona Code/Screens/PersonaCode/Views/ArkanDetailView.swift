//
//  ArkanDetailView.swift
//  DestinyMatrix
//
//  Created by Иван Семикин on 11/11/2024.
//

import SwiftUI

struct ArkanDetailView: View {
    @State var arkanInfo: ArkanInfo
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(arkanInfo.title)
                .font(.system(size: 21))
                .bold()
            
            ForEach(arkanInfo.subcategories, id: \.self) { subcategorie in
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
        AnimatedStarryBackgroundView()
        
        ArkanDetailView(arkanInfo: DestinyNumberArkans.allArkans[1]!)
    }
}
