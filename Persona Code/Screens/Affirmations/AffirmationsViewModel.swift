//
//  AffirmationsViewModel.swift
//  Persona Code
//
//  Created by Иван Семикин on 03/03/2025.
//

import Foundation

final class AffirmationsViewModel: ObservableObject {
    @Published var selectedCategory: AffirmationCategoryType = .all
    @Published var showFavoritesOnly: Bool = false
    @Published var affirmations: [Affirmation] = AffirmationStorage.shared.allAffirmations
    
    let categories = AffirmationCategoryType.allCases
    
    // Фильтрация аффирмаций по избранному и категории
    var filteredAffirmations: [Affirmation] {
        let filteredByFavorites = showFavoritesOnly
            ? affirmations.filter { $0.isFavorite }
            : affirmations
        
        if selectedCategory == .all {
            return filteredByFavorites
        } else {
            return filteredByFavorites.filter { $0.category == selectedCategory }
        }
    }
    
    // Переключение избранного
    func toggleFavorite(for affirmation: Affirmation) {
        if let index = affirmations.firstIndex(where: { $0.id == affirmation.id }) {
            affirmations[index].isFavorite.toggle()
        }
    }
}
