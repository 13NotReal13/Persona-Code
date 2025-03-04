//
//  SettingsView.swift
//  Persona Code
//
//  Created by Иван Семикин on 03/03/2025.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var coordinator: NavigationCoordinator
    @StateObject private var viewModel = SettingsViewModel.shared
    
    var body: some View {
        ZStack {
            BackgroundView(isAnimated: false)
            ShadowBackgroundView(isHighShadowLevel: true)
            
            Form {
                NotificationTogglesView()
                    .environmentObject(viewModel)
                
                Section(header: Text("Язык")) {
                    Picker("Язык интерфейса", selection: $viewModel.selectedLanguage) {
                        ForEach(viewModel.availableLanguages, id: \.self) { language in
                            Text(language).tag(language)
                        }
                    }
                }
                .listRowBackground(Color.white.opacity(0.1))
                
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
                
                Section(header: Text("Покупки")) {
                    Button("Восстановить покупки") {
                        IAPManager.shared.restorePurchases()
                    }
                }
                .listRowBackground(Color.white.opacity(0.1))
                
                Section(header: Text("Оценки и отзывы")) {
                    Button("Оценить приложение") {
                        ReviewRequestManager.shared.requestReview()
                    }
                }
                .listRowBackground(Color.white.opacity(0.1))
                
                Section(header: Text("Поддержка")) {
                    Button("Связаться с разработчиком") {
                        ReviewRequestManager.shared.showFeedbackForm()
                    }
                }
                .listRowBackground(Color.white.opacity(0.1))
            }
            .scrollContentBackground(.hidden)
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
