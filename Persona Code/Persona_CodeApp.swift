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

    @State private var showOnboarding = false

    var body: some Scene {
        WindowGroup {
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

                    refreshFactNotifications()

                    if !onboardingWasShowing {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            showOnboarding = true
                        }
                    }
                }
                .fullScreenCover(isPresented: $showOnboarding, onDismiss: {
                    onboardingWasShowing = true
                    appSettings.getNotificationRequest()
                }) {
                    NavigationStack {
                        OnboardingView()
                            .preferredColorScheme(.dark)
                    }
                }
        }
    }

    private func refreshFactNotifications() {
        if appSettings.isFactNotificationEnabled && !appSettings.selectedDays(for: .dailyFact).isEmpty {
            let days = appSettings.selectedDays(for: .dailyFact)
            NotificationManager.shared.scheduleDailyFactsForMonth(at: appSettings.factsDate, selectedDays: days)
        }
    }
}

