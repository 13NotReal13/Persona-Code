//
//  HelpInfoCategoriesView.swift
//  Persona Code
//
//  Created by Иван Семикин on 24/02/2025.
//

import SwiftUI

struct HelpInfoCategoriesView: View {
    let categories: [CodeInfo]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                ForEach(categories, id: \.title) { category in
                    Text(category.title)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            
            VStack(spacing: 16) {
                ForEach(categories, id: \.title) { category in
                    // Заголовок категории
                    Text(category.title)
                        .font(.system(size: 21))
                        .bold()
                        .foregroundStyle(.white)
                        .padding(.top)
                    
                    VStack(spacing: 16) {
                        ForEach(category.subcategories, id: \.title) { subcategory in
                            VStack(alignment: .leading, spacing: 4) {
                                // Заголовок подкатегории
                                Text(subcategory.title)
                                    .foregroundStyle(.white)
                                // Описание подкатегории
                                Text(subcategory.shortDescription)
                                    .foregroundStyle(.white.opacity(0.8))
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    ZStack {
        BackgroundView()
        
        ShadowBackgroundView()
        
        HelpInfoCategoriesView(categories: HelpInfoViewModel().categories)
    }
}
