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
            VStack(spacing: 16) {
                ForEach(categories, id: \.title) { category in
                    // Заголовок категории
                    Text(category.title)
                        .font(.title2)
                        .bold()
                    
                    VStack(alignment: .leading, spacing: 16) {
                        ForEach(category.subcategories, id: \.title) { subcategory in
                            VStack(alignment: .leading, spacing: 4) {
                                // Заголовок подкатегории
                                Text(subcategory.title)
                                    .font(.headline)
                                    .bold()
                                // Описание подкатегории
                                Text(subcategory.shortDescription)
                                    .foregroundStyle(.white.opacity(0.8))
                            }
                        }
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
