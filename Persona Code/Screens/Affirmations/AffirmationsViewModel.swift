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
    
    @Published var reminderTime = Date()
    @Published var isReminderEnabled = false
    @Published var selectedDays: Set<Int> = []
    
    static let shared = AffirmationsViewModel()
    
    let categories = AffirmationCategoryType.allCases
    let weekDays = ["Вс", "Пн", "Вт", "Ср", "Чт", "Пт", "Сб"]
    
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
    
    private init() {
        NotificationManager.shared.requestAuthorization()
    }
    
    func updateReminders() {
        if isReminderEnabled && !selectedDays.isEmpty {
            NotificationManager.shared.scheduleWeeklyReminders(on: Array(selectedDays), at: reminderTime)
        } else {
            NotificationManager.shared.removeAllReminders()
        }
    }
    
    func toggleDaySelection(_ day: Int) {
        if selectedDays.contains(day) {
            selectedDays.remove(day)
        } else {
            selectedDays.insert(day)
        }
        updateReminders()
    }
    
    // Переключение избранного
    func toggleFavorite(for affirmation: Affirmation) {
        if let index = affirmations.firstIndex(where: { $0.id == affirmation.id }) {
            affirmations[index].isFavorite.toggle()
        }
    }
}
