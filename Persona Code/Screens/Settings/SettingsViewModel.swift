//
//  SettingsViewModel.swift
//  Persona Code
//
//  Created by Иван Семикин on 04/03/2025.
//

import Foundation
import SwiftUI

final class SettingsViewModel: ObservableObject {
    static let shared = SettingsViewModel()
    
    // MARK: - Настройки языка
    @AppStorage("selectedLanguage") var selectedLanguage = "Русский"
    let availableLanguages = ["Русский", "Польский", "Английский"]
    
    // MARK: - Настройки уведомлений
    @AppStorage("isReminderEnabled") var isReminderEnabled: Bool = false
    @AppStorage("isWishNotificationEnabled") var isWishNotificationEnabled: Bool = false
    @AppStorage("selectedDays") var selectedDaysData: Data = Data()
    @AppStorage("selectedWishDays") var selectedWishDaysData: Data = Data()
    @AppStorage("reminderTime") var reminderTime: Double = Date().timeIntervalSince1970
    @AppStorage("wishTime") var wishTime: Double = Date().timeIntervalSince1970
    @AppStorage("isFirstLaunch") private var isFirstLaunch = true

    let weekDays = ["Вс", "Пн", "Вт", "Ср", "Чт", "Пт", "Сб"]
    
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
    
    private init() {
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
