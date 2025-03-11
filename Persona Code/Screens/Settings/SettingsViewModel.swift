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
    @AppStorage("isFactNotificationEnabled") var isFactNotificationEnabled: Bool = false
    @AppStorage("selectedDays") var selectedDaysData: Data = Data()
    @AppStorage("selectedFactsDays") var selectedFactsDaysData: Data = Data()
    @AppStorage("reminderTime") var reminderTime: Double = Date().timeIntervalSince1970
    @AppStorage("factTime") var factTime: Double = Date().timeIntervalSince1970
    @AppStorage("isFirstLaunch") private var isFirstLaunch = true

    let weekDays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    var reminderDate: Date {
        get { Date(timeIntervalSince1970: reminderTime) }
        set { reminderTime = newValue.timeIntervalSince1970 }
    }
    
    var wishDate: Date {
        get { Date(timeIntervalSince1970: factTime) }
        set { factTime = newValue.timeIntervalSince1970 }
    }
    
    func selectedDays(for type: ReminderType) -> Set<Int> {
        let data = (type == .affirmation) ? selectedDaysData : selectedFactsDaysData
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
            selectedFactsDaysData = encoded ?? Data()
            updateFactsNotifications()
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
    
    func updateFactsNotifications() {
        if isFactNotificationEnabled && !selectedDays(for: .dailyFact).isEmpty {
            NotificationManager.shared.scheduleDailyFactsNotification(at: wishDate)
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
                self.isFactNotificationEnabled = false
            }
        }
    }
    
    private func setupDefaultWishNotifications() {
        isFactNotificationEnabled = true
        let allDays = Set(1...7)
        setSelectedDays(allDays, for: .dailyFact)
        
        if let tenAM = Calendar.current.date(bySettingHour: 10, minute: 0, second: 0, of: Date()) {
            factTime = tenAM.timeIntervalSince1970
        }
        
        updateFactsNotifications()
    }
}

extension SettingsViewModel {
    func changeLanguage(to language: String) {
        currentLanguage = language
        locale = Locale(identifier: language)
        
        updateFactsNotifications()
        
        AffirmationsViewModel.shared.loadAffirmations()
    }
}
