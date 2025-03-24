//
//  ReviewRequestManager.swift
//  Persona Code
//
//  Created by Иван Семикин on 24/02/2025.
//

import SwiftUI
import StoreKit
import MessageUI

final class ReviewRequestManager: NSObject, ObservableObject, MFMailComposeViewControllerDelegate {
    
    static let shared = ReviewRequestManager()
    private override init() {}
    
    @AppStorage("hasSeenReviewPrompt") private var hasSeenReviewPrompt: Bool = false
    
    private let minPersonaCodesCount = 2
    
    func reviewPromptWasShowing() -> Bool {
        return hasSeenReviewPrompt
    }
    
    func checkReviewConditions(personaCodesCount: Int) {
        guard !hasSeenReviewPrompt else { return }
     
        if personaCodesCount >= minPersonaCodesCount {
            showFeedbackAlert()
        }
    }
    
    // Форма обратной связи
    func showFeedbackForm() {
        // Проверяем, доступна ли почта на устройстве
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["i.semikin.94@icloud.com"])
            mail.setSubject(localizedString("Feedback from the app - Personality Code"))
            mail.setMessageBody(localizedString("Describe your issue or suggestion here…"), isHTML: false)
            
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let rootVC = windowScene.windows.first?.rootViewController {
                rootVC.present(mail, animated: true)
            }
        } else {
            // Если почта недоступна
            let alert = UIAlertController(
                title: localizedString("Mail is unavailable"),
                message: localizedString("The mail client is not set up on the device. You can write to us at i.semikin.94@icloud.com"),
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: localizedString("OK"), style: .default))
            
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let rootVC = windowScene.windows.first?.rootViewController {
                rootVC.present(alert, animated: true)
            }
        }
    }
    
    func requestReview() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            SKStoreReviewController.requestReview(in: windowScene)
            hasSeenReviewPrompt = true
        }
    }
    
    private func showFeedbackAlert() {
        let alert = UIAlertController(
            title: localizedString("We value your opinion"),
            message: localizedString("Do you find this app useful?"),
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: localizedString("Yes"), style: .default, handler: { _ in
            FirebaseLogsManager.shared.logButtonTapped(.reviewAlertAccepted)
            self.requestReview()
        }))
        
        alert.addAction(UIAlertAction(title: localizedString("No"), style: .cancel, handler: { _ in
            FirebaseLogsManager.shared.logButtonTapped(.reviewAlertDeclined)
            self.hasSeenReviewPrompt = true
        }))
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootVC = windowScene.windows.first?.rootViewController {
            rootVC.present(alert, animated: true)
        }
    }
    
    // Закрытие почтового клиента
    func mailComposeController(
        _ controller: MFMailComposeViewController,
        didFinishWith result: MFMailComposeResult,
        error: Error?
    ) {
        controller.dismiss(animated: true, completion: nil)
    }
}
