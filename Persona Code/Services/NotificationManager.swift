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
    
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in }
    }
    
    func scheduleWeeklyReminders(on days: [Int], at time: Date) {
        removeAllReminders()
        
        for day in days {
            let content = UNMutableNotificationContent()
            content.title = "Аффирмации дня"
            content.body = "Не забудьте прочитать свои аффирмации!"
            content.sound = .default
            
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
    
    func removeAllReminders() {
        let identifiers = (1...7).map { "affirmationReminder-\($0)" }
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiers)
    }
}
