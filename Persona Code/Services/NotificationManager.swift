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
    func scheduleDailyFactsForMonth(at time: Date, selectedDays: Set<Int>) {
        removeFactsNotifications()
        
        let calendar = Calendar.current

        for dayOffset in 0..<31 {
            guard let targetDate = calendar.date(byAdding: .day, value: dayOffset, to: Date()) else { continue }
            
            let weekday = calendar.component(.weekday, from: targetDate)

            if selectedDays.contains(weekday) {
                var dateComponents = calendar.dateComponents([.hour, .minute], from: time)
                dateComponents.day = calendar.component(.day, from: targetDate)
                dateComponents.month = calendar.component(.month, from: targetDate)
                dateComponents.year = calendar.component(.year, from: targetDate)
                
                let content = UNMutableNotificationContent()
                content.title = localizedString("Amazing Fact")
                content.body = getRandomFactForCurrentLanguage()
                content.sound = .default
                content.categoryIdentifier = "DAILY_FACTS_CATEGORY"
                
                let request = UNNotificationRequest(
                    identifier: "fact-notification-\(calendar.component(.day, from: targetDate))-\(calendar.component(.month, from: targetDate))-\(calendar.component(.year, from: targetDate))",
                    content: content,
                    trigger: UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
                )
                
                UNUserNotificationCenter.current().add(request)
            }
        }
    }
    
    func getRandomFactForCurrentLanguage() -> String {
        let language = UserDefaults.standard.string(forKey: "currentLanguage") ?? "en"
        
        let fact: String
        switch language {
        case "ru": fact = DailyFactsStorage_RU.shared.getRandomFact()
        case "pl": fact = DailyFactsStorage_PL.shared.getRandomFact()
        default: fact = DailyFactsStorage_EN.shared.getRandomFact()
        }
        
        return fact
    }
    
    // 🔄 Удаляем все напоминания об аффирмациях
    func removeAllReminders() {
        let affirmationIdentifiers = (1...7).map { "affirmationReminder-\($0)" }
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: affirmationIdentifiers)
    }
    
    // 🔄 Удаляем все ежедневные пожелания
    func removeFactsNotifications() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
            let factIDs = requests
                .filter { $0.identifier.starts(with: "fact-notification-") }
                .map { $0.identifier }
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: factIDs)
        }
    }
}
