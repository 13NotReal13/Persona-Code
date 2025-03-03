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
    
    @AppStorage("selectedCategory") var selectedCategoryRawValue: String = AffirmationCategoryType.all.rawValue
    @AppStorage("showFavoritesOnly") var showFavoritesOnly: Bool = false
    @AppStorage("isReminderEnabled") var isReminderEnabled: Bool = false
    @AppStorage("selectedDays") var selectedDaysData: Data = Data()
    @AppStorage("reminderTime") var reminderTime: Double = Date().timeIntervalSince1970

    @Published var affirmations: [Affirmation] = AffirmationStorage.shared.allAffirmations

    let categories = AffirmationCategoryType.allCases
    let weekDays = ["Вс", "Пн", "Вт", "Ср", "Чт", "Пт", "Сб"]
    var reminderDate: Date {
        get { Date(timeIntervalSince1970: reminderTime) }
        set { reminderTime = newValue.timeIntervalSince1970 }
    }
    
    // Восстановление категорий из @AppStorage
    var selectedCategory: AffirmationCategoryType {
        get { AffirmationCategoryType(rawValue: selectedCategoryRawValue) ?? .all }
        set { selectedCategoryRawValue = newValue.rawValue }
    }
    
    // Восстановление выбранных дней из @AppStorage
    var selectedDays: Set<Int> {
        get {
            if let decoded = try? JSONDecoder().decode(Set<Int>.self, from: selectedDaysData) {
                return decoded
            }
            return []
        }
        set {
            if let encoded = try? JSONEncoder().encode(newValue) {
                selectedDaysData = encoded
            }
            updateReminders()
        }
    }
    
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
        loadFavorites()
    }
    
    // Сохранение избранных аффирмаций
    func saveFavorites() {
        if let encoded = try? JSONEncoder().encode(affirmations) {
            UserDefaults.standard.set(encoded, forKey: "favoriteAffirmations")
        }
    }
    
    // Загрузка избранных аффирмаций
    func loadFavorites() {
        if let savedData = UserDefaults.standard.data(forKey: "favoriteAffirmations"),
           let decoded = try? JSONDecoder().decode([Affirmation].self, from: savedData) {
            affirmations = decoded
        }
    }
    
    func updateReminders() {
        if isReminderEnabled && !selectedDays.isEmpty {
            NotificationManager.shared.scheduleWeeklyReminders(on: Array(selectedDays), at: reminderDate)
        } else {
            NotificationManager.shared.removeAllReminders()
        }
    }
    
    func toggleDaySelection(_ day: Int) {
        var days = selectedDays
        if days.contains(day) {
            days.remove(day)
        } else {
            days.insert(day)
        }
        selectedDays = days
    }
    
    // Переключение избранного
    func toggleFavorite(for affirmation: Affirmation) {
        if let index = affirmations.firstIndex(where: { $0.id == affirmation.id }) {
            affirmations[index].isFavorite.toggle()
            saveFavorites()
        }
    }
}
