//
//  ScrollCategoriesView.swift
//  Persona Code
//
//  Created by Иван Семикин on 04/03/2025.
//

import SwiftUI

struct ScrollCategoriesView: View {
    @Binding var selectedCategory: AffirmationCategoryType
    let categories: [AffirmationCategoryType]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .bottom, spacing: 1) {
                ForEach(categories) { category in
                    Button(action: {
                        selectedCategory = category
                    }) {
                        VStack {
                            Image(systemName: category.icon)
                                .font(.title)
                                .foregroundColor(
                                    selectedCategory == category
                                    ? .white
                                    : .gray
                                )
                            Text(category.displayName)
                                .font(.caption)
                                .foregroundColor(
                                    selectedCategory == category
                                    ? .white
                                    : .gray
                                )
                        }
                        .padding()
                        .background(
                            selectedCategory == category
                            ? Color.brown.opacity(0.2)
                            : Color.clear
                        )
                        .cornerRadius(10)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    ScrollCategoriesView(
        selectedCategory: .constant(AffirmationCategoryType.all),
        categories: AffirmationCategoryType.allCases
    )
}
