//
//  SettingsView.swift
//  Persona Code
//
//  Created by Иван Семикин on 03/03/2025.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var coordinator: NavigationCoordinator
    @AppStorage("selectedLanguage") private var selectedLanguage = "Русский"
    
    let languages = ["Русский", "Польский", "Английский"]
    
    var body: some View {
        ZStack {
            BackgroundView(isAnimated: false)
            ShadowBackgroundView(isHighShadowLevel: true)
            
            Form {
                Section(header: Text("Уведомления")) {
                    Toggle("Напоминания об аффирмациях", isOn: .constant(true))
                        .onTapGesture {
                            coordinator.present(.reminderPicker)
                        }
                    
                    Toggle("Ежедневные вдохновения", isOn: .constant(true))
                    
                    Button("Отправить тестовое уведомление") {
//                        NotificationManager.shared.sendTestNotification()
                    }
                }
                .listRowBackground(Color.white.opacity(0.1))
                .background(Color.clear)
                
                Section(header: Text("Язык")) {
                    Picker("Язык интерфейса", selection: $selectedLanguage) {
                        ForEach(languages, id: \.self) { language in
                            Text(language).tag(language)
                        }
                    }
                }
                .listRowBackground(Color.white.opacity(0.1))
                .background(Color.clear)
                
                Section(header: Text("Конфиденциальность")) {
                    Button("Политика конфиденциальности") {
                        if let url = URL(string: "https://example.com/privacy") {
                            UIApplication.shared.open(url)
                        }
                    }
                    Button("Условия использования") {
                        if let url = URL(string: "https://example.com/terms") {
                            UIApplication.shared.open(url)
                        }
                    }
                }
                .listRowBackground(Color.white.opacity(0.1))
                .background(Color.clear)
                
                Section(header: Text("Покупки")) {
                    Button("Восстановить покупки") {
                        IAPManager.shared.restorePurchases()
                    }
                }
                .listRowBackground(Color.white.opacity(0.1))
                .background(Color.clear)
                
                Section(header: Text("Оценки и отзывы")) {
                    Button("Оценить приложение") {
//                        SKStoreReviewController.requestReview()
                    }
                }
                .listRowBackground(Color.white.opacity(0.1))
                .background(Color.clear)
            }
            .scrollContentBackground(.hidden)
            .background(Color.clear)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    NavigationBackButtonView { coordinator.pop() }
                }
                ToolbarItem(placement: .principal) {
                    CustomNavigationTitleView(title: "Настройки")
                }
            }
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        SettingsView()
            .preferredColorScheme(.dark)
            .environmentObject(NavigationCoordinator())
    }
}
