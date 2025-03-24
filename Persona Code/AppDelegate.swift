//
//  AppDelegate.swift
//  Persona Code
//
//  Created by Иван Семикин on 22/03/2025.
//

import Foundation
import UIKit
import Firebase
import FirebaseMessaging
import UserNotifications

final class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        // 🔔 Настройка уведомлений
        UNUserNotificationCenter.current().delegate = self
        requestNotificationAuthorization()
        Messaging.messaging().delegate = self
        
        return true
    }
    
    // Запрашиваем разрешение на пуши
    private func requestNotificationAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    // Получение токена для FCM
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("FCM Token: \(fcmToken ?? "")")
    }
    
    // Отображение пуша при открытом приложении
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        if notification.request.content.categoryIdentifier == "AFFIRMATION_CATEGORY" {
            FirebaseLogsManager.shared.logNotificationShown(.affirmation)
        } else if notification.request.content.categoryIdentifier == "DAILY_FACTS_CATEGORY" {
            FirebaseLogsManager.shared.logNotificationShown(.fact)
        }
        
        completionHandler([.banner, .sound, .badge])
    }
}
