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
                    Text(localizedString(category.title))
                        .font(.title2)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        ForEach(category.subcategories, id: \.title) { subcategory in
                            VStack(alignment: .leading, spacing: 4) {
                                // Заголовок подкатегории
                                Text(localizedString(subcategory.title))
                                    .font(.headline)
                                    .bold()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                // Описание подкатегории
                                Text(localizedString(subcategory.shortDescription))
                                    .foregroundStyle(.white.opacity(0.8))
                                    .frame(maxWidth: .infinity, alignment: .leading)
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
        
        HelpInfoCategoriesView(categories: InfoContentData_EN().categories)
    }
    .preferredColorScheme(.dark)
}
