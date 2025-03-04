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
                completion(granted)
            }
        }
    }
    
    // 🔄 Еженедельные напоминания об аффирмациях
    func scheduleWeeklyReminders(on days: [Int], at time: Date) {
        removeAllReminders()
        
        for day in days {
            let content = UNMutableNotificationContent()
            content.title = "Аффирмации дня"
            content.body = "Не забудьте прочитать свои аффирмации!"
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
    func scheduleDailyWishNotification(at time: Date) {
        removeWishNotifications()  // Сначала удаляем старые уведомления
        
        let content = UNMutableNotificationContent()
        content.title = "Пожелание на день"
        content.body = WishStorage.shared.getRandomWish()
        content.sound = .default
        content.categoryIdentifier = "WISH_CATEGORY"
        
        var dateComponents = Calendar.current.dateComponents([.hour, .minute], from: time)
        dateComponents.second = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(
            identifier: "dailyWishNotification",
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Ошибка при добавлении уведомления: \(error.localizedDescription)")
            } else {
                print("✅ Уведомление запланировано на \(time)")
            }
        }
    }
    
    // 🔄 Удаляем все напоминания об аффирмациях
    func removeAllReminders() {
        let affirmationIdentifiers = (1...7).map { "affirmationReminder-\($0)" }
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: affirmationIdentifiers)
    }
    
    // 🔄 Удаляем все ежедневные пожелания
    func removeWishNotifications() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["dailyWishNotification"])
    }
}
