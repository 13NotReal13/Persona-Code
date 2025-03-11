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
    @AppStorage("currentLanguage") private var currentLanguage: String = "en"
    
    @Published private(set) var affirmations: [Affirmation] = []

    let categories = AffirmationCategoryType.allCases
    
    /// Отфильтрованный список аффирмаций
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
    
    private init() {
        loadAffirmations()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { // Даем время на обновление списка
            self.loadFavorites()
        }
    }

    /// Загружаем аффирмации в зависимости от текущего языка
    func loadAffirmations() {
        switch currentLanguage {
        case "pl":
            affirmations = AffirmationsStorage_PL.shared.allAffirmations
        case "ru":
            affirmations = AffirmationsStorage_RU.shared.allAffirmations
        default:
            affirmations = AffirmationsStorage_EN.shared.allAffirmations
        }
    }
    
    func saveFavorites() {
        let favoriteIDs = Set(affirmations.filter { $0.isFavorite }.map { $0.id })

        if let encoded = try? JSONEncoder().encode(favoriteIDs) {
            UserDefaults.standard.set(encoded, forKey: "favoriteAffirmations")
        }
    }
    
    func loadFavorites() {
        if let savedData = UserDefaults.standard.data(forKey: "favoriteAffirmations"),
           let decodedFavorites = try? JSONDecoder().decode(Set<UUID>.self, from: savedData) {
            DispatchQueue.main.async {
                self.affirmations = self.affirmations.map { affirmation in
                    var mutableAffirmation = affirmation
                    mutableAffirmation.isFavorite = decodedFavorites.contains(affirmation.id)
                    return mutableAffirmation
                }
            }
        }
    }
    
    /// Переключение избранного состояния
    func toggleFavorite(for affirmation: Affirmation) {
        if let index = affirmations.firstIndex(where: { $0.id == affirmation.id }) {
            objectWillChange.send() // 🔹 Сообщаем SwiftUI о предстоящем изменении
            var updatedAffirmation = affirmations[index] // 🔹 Копируем объект
            updatedAffirmation.isFavorite.toggle() // 🔹 Меняем его
            affirmations[index] = updatedAffirmation // 🔹 Заменяем в массиве
            saveFavorites()
        }
    }
}
