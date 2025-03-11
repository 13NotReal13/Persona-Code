//
//  SettingsViewModel.swift
//  Persona Code
//
//  Created by Иван Семикин on 04/03/2025.
//

import Foundation
import SwiftUI

final class SettingsViewModel: ObservableObject {
    // MARK: - Настройки языка
    @AppStorage("currentLanguage") var currentLanguage: String = "en"
    @Published var locale = Locale(identifier: "en")
    
    // MARK: - Настройки уведомлений
    @AppStorage("isReminderEnabled") var isReminderEnabled: Bool = false
    @AppStorage("isWishNotificationEnabled") var isWishNotificationEnabled: Bool = false
    @AppStorage("selectedDays") var selectedDaysData: Data = Data()
    @AppStorage("selectedWishDays") var selectedWishDaysData: Data = Data()
    @AppStorage("reminderTime") var reminderTime: Double = Date().timeIntervalSince1970
    @AppStorage("wishTime") var wishTime: Double = Date().timeIntervalSince1970
    @AppStorage("isFirstLaunch") private var isFirstLaunch = true

    let weekDays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    var reminderDate: Date {
        get { Date(timeIntervalSince1970: reminderTime) }
        set { reminderTime = newValue.timeIntervalSince1970 }
    }
    
    var wishDate: Date {
        get { Date(timeIntervalSince1970: wishTime) }
        set { wishTime = newValue.timeIntervalSince1970 }
    }
    
    func selectedDays(for type: ReminderType) -> Set<Int> {
        let data = (type == .affirmation) ? selectedDaysData : selectedWishDaysData
        if let decoded = try? JSONDecoder().decode(Set<Int>.self, from: data) {
            return decoded
        }
        return []
    }
    
    func setSelectedDays(_ days: Set<Int>, for type: ReminderType) {
        let encoded = try? JSONEncoder().encode(days)
        if type == .affirmation {
            selectedDaysData = encoded ?? Data()
            updateReminders()
        } else {
            selectedWishDaysData = encoded ?? Data()
            updateWishNotifications()
        }
    }
    
    func toggleDaySelection(_ day: Int, for type: ReminderType) {
        var days = selectedDays(for: type)
        if days.contains(day) {
            days.remove(day)
        } else {
            days.insert(day)
        }
        setSelectedDays(days, for: type)
    }
    
    func updateReminders() {
        if isReminderEnabled && !selectedDays(for: .affirmation).isEmpty {
            NotificationManager.shared.scheduleWeeklyReminders(on: Array(selectedDays(for: .affirmation)), at: reminderDate)
        } else {
            NotificationManager.shared.removeAllReminders()
        }
    }
    
    func updateWishNotifications() {
        if isWishNotificationEnabled && !selectedDays(for: .wish).isEmpty {
            NotificationManager.shared.scheduleDailyWishNotification(at: wishDate)
        } else {
            NotificationManager.shared.removeWishNotifications()
        }
    }
    
    init() {
        // MARK: - AppLanguage
        let savedLanguage = UserDefaults.standard.string(forKey: "currentLanguage")
        let deviceLanguage = Locale.preferredLanguages.first?.prefix(2).description ?? "en"

        if let savedLanguage = savedLanguage {
            currentLanguage = savedLanguage
        } else {
            if ["en", "pl", "ru"].contains(deviceLanguage) {
                currentLanguage = deviceLanguage
            } else {
                currentLanguage = "en"
            }
        }

        locale = Locale(identifier: currentLanguage)
        
        // MARK: - Notifications
        NotificationManager.shared.requestAuthorization { granted in
            if granted {
                if self.isFirstLaunch {
                    self.setupDefaultWishNotifications()
                    self.isFirstLaunch = false
                }
            } else {
                self.isWishNotificationEnabled = false
            }
        }
    }
    
    private func setupDefaultWishNotifications() {
        isWishNotificationEnabled = true
        let allDays = Set(1...7)
        setSelectedDays(allDays, for: .wish)
        
        if let tenAM = Calendar.current.date(bySettingHour: 10, minute: 0, second: 0, of: Date()) {
            wishTime = tenAM.timeIntervalSince1970
        }
        
        updateWishNotifications()
    }
}

extension SettingsViewModel {
    func changeLanguage(to language: String) {
        currentLanguage = language
        locale = Locale(identifier: language)
        print("🌍 Сменили язык на: \(language), текущая локаль: \(locale.identifier)")
    }
}
