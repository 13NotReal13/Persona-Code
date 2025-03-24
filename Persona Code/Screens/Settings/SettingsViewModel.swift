//
//  SettingsViewModel.swift
//  Persona Code
//
//  Created by Иван Семикин on 04/03/2025.
//

import Foundation
import SwiftUI

enum NotificationStateKeys {
    static let reminderLastState = "reminder_last_state"
    static let factsLastState = "facts_last_state"
}

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
    
    var factsDate: Date {
        get { Date(timeIntervalSince1970: factTime) }
        set { factTime = newValue.timeIntervalSince1970 }
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
                    self.setupDefaultFactsNotifications()
                    self.isFirstLaunch = false
                }
            } else {
                self.isFactNotificationEnabled = false
            }
        }
    }
    
    func selectedDays(for type: ReminderType) -> Set<Int> {
        let data = (type == .affirmation) ? selectedDaysData : selectedFactsDaysData
        if let decoded = try? JSONDecoder().decode(Set<Int>.self, from: data) {
            return decoded
        }
        return []
    }
    
    func setSelectedDays(_ days: Set<Int>, for type: ReminderType, autoUpdate: Bool = true) {
        let encoded = try? JSONEncoder().encode(days)
        if type == .affirmation {
            selectedDaysData = encoded ?? Data()
            if autoUpdate { updateReminders() }
        } else {
            selectedFactsDaysData = encoded ?? Data()
            if autoUpdate { updateFactsNotifications() }
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
        let wasEnabled = UserDefaults.standard.bool(forKey: NotificationStateKeys.reminderLastState)
        
        if isReminderEnabled {
            if selectedDays(for: .affirmation).isEmpty {
                setupDefaultAffirmationNotifications()
                return
            }
            
            NotificationManager.shared.scheduleWeeklyReminders(
                on: Array(selectedDays(for: .affirmation)),
                at: reminderDate
            )
            
            if !wasEnabled {
                FirebaseLogsManager.shared.logNotificationToggled(.affirmation, isEnabled: true)
                UserDefaults.standard.set(true, forKey: NotificationStateKeys.reminderLastState)
            }
        } else {
            NotificationManager.shared.removeAllReminders()
            
            if wasEnabled {
                FirebaseLogsManager.shared.logNotificationToggled(.affirmation, isEnabled: false)
                UserDefaults.standard.set(false, forKey: NotificationStateKeys.reminderLastState)
            }
        }
    }
    
    func updateFactsNotifications() {
        let wasEnabled = UserDefaults.standard.bool(forKey: NotificationStateKeys.factsLastState)
        
        if isFactNotificationEnabled && !selectedDays(for: .dailyFact).isEmpty {
            let days = selectedDays(for: .dailyFact)
            NotificationManager.shared.scheduleDailyFactsForMonth(at: factsDate, selectedDays: days)
            
            if !wasEnabled {
                FirebaseLogsManager.shared.logNotificationToggled(.fact, isEnabled: true)
                UserDefaults.standard.set(true, forKey: NotificationStateKeys.factsLastState)
            }
        } else {
            NotificationManager.shared.removeFactsNotifications()
            
            if wasEnabled {
                FirebaseLogsManager.shared.logNotificationToggled(.fact, isEnabled: false)
                UserDefaults.standard.set(false, forKey: NotificationStateKeys.factsLastState)
            }
        }
    }
    
    private func setupDefaultFactsNotifications() {
        isFactNotificationEnabled = true
        let allDays = Set(1...7)
        setSelectedDays(allDays, for: .dailyFact, autoUpdate: false)
        
        if let tenAM = Calendar.current.date(bySettingHour: 10, minute: 0, second: 0, of: Date()) {
            factTime = tenAM.timeIntervalSince1970
        }
        
        updateFactsNotifications()
    }
    
    func setupDefaultAffirmationNotifications() {
        isReminderEnabled = true
        let allDays = Set(1...7)
        setSelectedDays(allDays, for: .affirmation)
        
        reminderTime = Date().timeIntervalSince1970
        
        updateReminders()
    }
}

extension SettingsViewModel {
    func changeLanguage(to language: String) {
        currentLanguage = language
        locale = Locale(identifier: language)
        
        updateReminders()
        updateFactsNotifications()
        AffirmationsViewModel.shared.loadAffirmations()
    }
}
