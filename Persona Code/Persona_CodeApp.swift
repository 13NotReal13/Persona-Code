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
    @AppStorage("hasLaunchedBefore") private var hasLaunchedBefore: Bool = false
    
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
                }
        }
    }
}
