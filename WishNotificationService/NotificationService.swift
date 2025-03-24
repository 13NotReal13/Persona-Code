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
        
        if bestAttemptContent.categoryIdentifier == "DAILY_FACTS_CATEGORY" {
            let language = UserDefaults.standard.string(forKey: "currentLanguage") ?? "en"
            
            let fact: String
            switch language {
            case "ru": fact = DailyFactsStorage_RU.shared.getRandomFact()
            case "pl": fact = DailyFactsStorage_PL.shared.getRandomFact()
            default: fact = DailyFactsStorage_EN.shared.getRandomFact()
            }
            
            bestAttemptContent.title = localizedString("Amazing Fact")
            bestAttemptContent.body = fact
        }
        
        contentHandler(bestAttemptContent)
    }
}
