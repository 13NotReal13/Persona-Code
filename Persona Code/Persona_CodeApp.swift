//
//  Persona_CodeApp.swift
//  Persona Code
//
//  Created by Иван Семикин on 22/02/2025.
//

import SwiftUI
import FirebaseCore

@main
struct Persona_CodeApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var appSettings = SettingsViewModel()
    
    @AppStorage("onboardingWasShowing") private var onboardingWasShowing: Bool = false
    @AppStorage("hasLaunchedBefore") private var hasLaunchedBefore: Bool = false
    
    var body: some Scene {
        WindowGroup {
            if !onboardingWasShowing {
                NavigationStack {
                    OnboardingView()
                        .preferredColorScheme(.dark)
                }
            } else {
                HomeView()
                    .preferredColorScheme(.dark)
                    .environmentObject(appSettings)
                    .environment(\.locale, appSettings.locale)
                    .onAppear {
                        IAPManager.shared.startObserving()
                        IAPManager.shared.fetchProducts()
                        
                        if !hasLaunchedBefore {
                            FirebaseLogsManager.shared.logFirstLaunch()
                            hasLaunchedBefore = true
                        }
                        
                        appSettings.getNotificationRequest()
                        refreshFactNotifications()
                    }
            }
        }
    }
    
    private func refreshFactNotifications() {
        // Проверяем включены ли факты и есть ли выбранные дни
        if appSettings.isFactNotificationEnabled && !appSettings.selectedDays(for: .dailyFact).isEmpty {
            let days = appSettings.selectedDays(for: .dailyFact)
            NotificationManager.shared.scheduleDailyFactsForMonth(at: appSettings.factsDate, selectedDays: days)
        }
    }
}

