//
//  AffirmationsViewModel.swift
//  Persona Code
//
//  Created by Иван Семикин on 03/03/2025.
//

import Foundation
import SwiftUI

final class AffirmationsViewModel: ObservableObject {
    static let shared = AffirmationsViewModel()
    
    @Published var selectedCategory: AffirmationCategoryType = .all
    @AppStorage("showFavoritesOnly") var showFavoritesOnly: Bool = false
    @Published var affirmations: [Affirmation] = AffirmationStorage.shared.allAffirmations

    let categories = AffirmationCategoryType.allCases
    
    private init() {
        loadFavorites()
    }
    
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
    
    func saveFavorites() {
        if let encoded = try? JSONEncoder().encode(affirmations) {
            UserDefaults.standard.set(encoded, forKey: "favoriteAffirmations")
        }
    }
    
    func loadFavorites() {
        if let savedData = UserDefaults.standard.data(forKey: "favoriteAffirmations"),
           let decoded = try? JSONDecoder().decode([Affirmation].self, from: savedData) {
            affirmations = decoded
        }
    }
    
    func toggleFavorite(for affirmation: Affirmation) {
        if let index = affirmations.firstIndex(where: { $0.id == affirmation.id }) {
            affirmations[index].isFavorite.toggle()
            saveFavorites()
        }
    }
}
