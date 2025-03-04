//
//  NotificationService.swift
//  WishNotificationService
//
//  Created by Иван Семикин on 04/03/2025.
//

import UserNotifications

class NotificationService: UNNotificationServiceExtension {
    
    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        guard let bestAttemptContent = request.content.mutableCopy() as? UNMutableNotificationContent else {
            contentHandler(request.content)
            return
        }
        
        if bestAttemptContent.categoryIdentifier == "WISH_CATEGORY" {
            let appGroupUserDefaults = UserDefaults(suiteName: "group.Ivan-Semikin.Persona-Code")
            let dailyWishKey = "dailyWish"
            
            let wish = WishStorage.shared.getRandomWish()
            bestAttemptContent.body = wish
            
            appGroupUserDefaults?.set(wish, forKey: dailyWishKey)
        }
        
        contentHandler(bestAttemptContent)
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Вызывается, если время истекает до завершения обработки уведомления
    }
}
