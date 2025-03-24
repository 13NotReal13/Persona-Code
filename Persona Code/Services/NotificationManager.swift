//
//  NotificationManager.swift
//  Persona Code
//
//  Created by Иван Семикин on 03/03/2025.
//

import Foundation
import UserNotifications

final class NotificationManager {
    static let shared = NotificationManager()
    
    private init() {}
    
    // 🔄 Запрос на авторизацию уведомлений
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            DispatchQueue.main.async {
                if granted {
                    self.registerNotificationCategories()
                }
                completion(granted)
            }
        }
    }
    
    func registerNotificationCategories() {
        let wishCategory = UNNotificationCategory(
            identifier: "DAILY_FACTS_CATEGORY",
            actions: [],
            intentIdentifiers: [],
            options: []
        )
        
        let affirmationCategory = UNNotificationCategory(
            identifier: "AFFIRMATION_CATEGORY",
            actions: [],
            intentIdentifiers: [],
            options: []
        )
        
        UNUserNotificationCenter.current().setNotificationCategories([wishCategory, affirmationCategory])
    }
    
    // 🔄 Еженедельные напоминания об аффирмациях
    func scheduleWeeklyReminders(on days: [Int], at time: Date) {
        removeAllReminders()
        
        for day in days {
            let content = UNMutableNotificationContent()
            content.title = localizedString("The Time Has Come!")
            content.body = localizedString("Remind yourself of your potential – take a minute for affirmations!")
            content.sound = .default
            content.categoryIdentifier = "AFFIRMATION_CATEGORY"
            
            var dateComponents = Calendar.current.dateComponents([.hour, .minute], from: time)
            dateComponents.weekday = day
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            let request = UNNotificationRequest(
                identifier: "affirmationReminder-\(day)",
                content: content,
                trigger: trigger
            )
            
            UNUserNotificationCenter.current().add(request) { error in }
        }
    }
    
    // 🔄 Ежедневные уведомления с пожеланиями
    func scheduleDailyFactTrigger(at time: Date) {
        removeWishNotifications()
        
        let content = UNMutableNotificationContent()
        content.sound = .default
        content.categoryIdentifier = "DAILY_FACTS_CATEGORY"
        
        var dateComponents = Calendar.current.dateComponents([.hour, .minute], from: time)
        dateComponents.second = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(
            identifier: "dailyFactsNotification",
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request) { error in }
    }
    
    // 🔄 Удаляем все напоминания об аффирмациях
    func removeAllReminders() {
        let affirmationIdentifiers = (1...7).map { "affirmationReminder-\($0)" }
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: affirmationIdentifiers)
    }
    
    // 🔄 Удаляем все ежедневные пожелания
    func removeWishNotifications() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["dailyFactsNotification"])
    }
}
