//
//  FirebaseLogsManager.swift
//  Persona Code
//
//  Created by Иван Семикин on 24/03/2025.
//

import Foundation
import FirebaseAnalytics

enum FirebaseLogs: String {
    case appEvent = "app_event"
    
    case screenShown = "screen_shown"
    case buttonTapped = "button_tapped"
    case notificationShown = "notification_shown"
    case notificationToggled = "notification_toggled"
    case purchaseSuccess = "purchase_success"
    case purchaseFailure = "purchase_failure"
    
    case pdfEvent = "pdf_event"
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

    case rate = "rate_app"
    case contact = "contact_support"

    case reviewAlertAccepted = "review_alert_accepted"
    case reviewAlertDeclined = "review_alert_declined"
}

enum NotificationType: String {
    case fact = "fact_notification"
    case affirmation = "affirmation_notification"
}

enum MusicToogle: String {
    case musicToggled = "music_toggled"
}

enum PDFDownload: String {
    case success = "success"
    case failure = "failure"
}

final class FirebaseLogsManager {
    static let shared = FirebaseLogsManager()
    
    private init() {}

    func logFirstLaunch() {
//        Analytics.logEvent(FirebaseLogs.appEvent.rawValue, parameters: ["event": "First Launch"])
    }

    func logScreenShown(_ screen: ScreenName) {
//        Analytics.logEvent(FirebaseLogs.screenShown.rawValue, parameters: [
//            "screen_name": screen.rawValue
//        ])
    }

    func logButtonTapped(_ button: ButtonName) {
//        Analytics.logEvent(FirebaseLogs.buttonTapped.rawValue, parameters: [
//            "button_name": button.rawValue
//        ])
    }

    func logNotificationShown(_ type: NotificationType) {
//        Analytics.logEvent(FirebaseLogs.notificationShown.rawValue, parameters: [
//            "notification_type": type.rawValue
//        ])
    }

    func logNotificationToggled(_ type: NotificationType, isEnabled: Bool) {
//        Analytics.logEvent(FirebaseLogs.notificationToggled.rawValue, parameters: [
//            "notification_type": type.rawValue,
//            "state": isEnabled ? "Enabled" : "Disabled"
//        ])
    }
    
    func logMusicToogle(isEnabled: Bool) {
//        Analytics.logEvent(MusicToogle.musicToggled.rawValue, parameters: ["state": isEnabled ? "Enabled" : "Disabled"])
    }

    func logPurchaseSuccess(name: String, dateBirth: String) {
//        Analytics.logEvent(
//            FirebaseLogs.purchaseSuccess.rawValue,
//            parameters: [
//                "name": name,
//                "date_birth": dateBirth
//            ]
//        )
    }

    func logPurchaseFailure() {
//        Analytics.logEvent(FirebaseLogs.purchaseFailure.rawValue, parameters: nil)
    }
    
    func logPDFDownloaded() {
//        Analytics.logEvent(FirebaseLogs.purchaseSuccess.rawValue, parameters: nil)
    }
    
    func logPDFEvent(isSuccess: Bool, errorDescription: String? = nil) {
//        var parameters: [String: Any] = [
//            "pdf_type": "persona_code",
//            "result": isSuccess ? "success" : "failure"
//        ]
//        
//        if let errorDescription = errorDescription {
//            parameters["error"] = errorDescription
//        }
//        
//        Analytics.logEvent(FirebaseLogs.pdfEvent.rawValue, parameters: parameters)
    }
}

