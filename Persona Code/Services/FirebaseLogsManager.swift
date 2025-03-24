//
//  FirebaseLogsManager.swift
//  Persona Code
//
//  Created by Иван Семикин on 24/03/2025.
//

import Foundation
import FirebaseAnalytics

enum FirebaseLogs: String {
    case screenShown = "screen_shown"
    case buttonTapped = "button_tapped"
    case notificationShown = "notification_shown"
    case notificationToggled = "notification_toggled"
    case purchaseSuccess = "purchase_success"
    case purchaseFailure = "purchase_failure"
    case appEvent = "app_event"
}

enum ScreenName: String {
    case enterData = "enter_data"
    case preload = "preload"
    case purchase = "purchase"
    case affirmations = "affirmations"
    case history = "history"
    case settings = "settings"
    case helpInfo = "help_info"
    case personaCode = "persona_code"
}

enum ButtonName: String {
    case downloadPDF = "download_pdf"
    case privacyPolicy = "privacy_policy"
    case termsOfUse = "terms_of_use"

    case confirmPurchase = "confirm_purchase"
    case cancelPurchase = "cancel_purchase"
    case restorePurchase = "restore_purchase"

    case rate = "rate_app"
    case contact = "contact_support"

    case reviewAlertAccepted = "review_alert_accepted"
    case reviewAlertDeclined = "review_alert_declined"
}

enum NotificationType: String {
    case fact = "fact_notification"
    case affirmation = "affirmation_notification"
}

final class FirebaseLogsManager {
    static let shared = FirebaseLogsManager()
    
    private init() {}

    func logFirstLaunch() {
        print("🔥 Logged: First Launch")
        Analytics.logEvent(FirebaseLogs.appEvent.rawValue, parameters: ["event": "First Launch"])
    }

    func logScreenShown(_ screen: ScreenName) {
        print("🔥 Logged: Screen Shown - \(screen.rawValue)")
        Analytics.logEvent(FirebaseLogs.screenShown.rawValue, parameters: [
            "screen_name": screen.rawValue
        ])
    }

    func logButtonTapped(_ button: ButtonName) {
        print("🔥 Logged: Button Tapped - \(button.rawValue)")
        Analytics.logEvent(FirebaseLogs.buttonTapped.rawValue, parameters: [
            "button_name": button.rawValue
        ])
    }

    func logNotificationShown(_ type: NotificationType) {
        print("🔥 Logged: Notification Shown - \(type.rawValue)")
        Analytics.logEvent(FirebaseLogs.notificationShown.rawValue, parameters: [
            "notification_type": type.rawValue
        ])
    }

    func logNotificationToggled(_ type: NotificationType, isEnabled: Bool) {
        print("🔥 Logged: Notification Toggled - \(type.rawValue) to \(isEnabled ? "Enabled" : "Disabled")")
        Analytics.logEvent(FirebaseLogs.notificationToggled.rawValue, parameters: [
            "notification_type": type.rawValue,
            "state": isEnabled ? "Enabled" : "Disabled"
        ])
    }

    func logPurchaseSuccess(name: String, dateBirth: String) {
        print("🔥 Logged: Purchase Success - Name: \(name), Date of Birth: \(dateBirth)")
        Analytics.logEvent(
            FirebaseLogs.purchaseSuccess.rawValue,
            parameters: [
                "name": name,
                "date_birth": dateBirth
            ]
        )
    }

    func logPurchaseFailure() {
        print("🔥 Logged: Purchase Failure")
        Analytics.logEvent(FirebaseLogs.purchaseFailure.rawValue, parameters: nil)
    }
}

