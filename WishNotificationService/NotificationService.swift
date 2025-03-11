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
            let appGroupUserDefaults = UserDefaults(suiteName: "group.Ivan-Semikin.Persona-Code")
            let dailyFactsKey = "dailyFactsKey"
            
            let language = UserDefaults.standard.string(forKey: "currentLanguage") ?? "en"
            let fact: String
            
            switch language {
            case "ru": fact = DailyFactsStorage_RU.shared.getRandomFact()
            case "pl": fact = DailyFactsStorage_PL.shared.getRandomFact()
            default: fact = DailyFactsStorage_EN.shared.getRandomFact()
            }
            
            bestAttemptContent.body = fact
            appGroupUserDefaults?.set(fact, forKey: dailyFactsKey)
        }
        
        contentHandler(bestAttemptContent)
    }
}
