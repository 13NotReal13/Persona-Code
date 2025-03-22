//
//  HomeView.swift
//  Persona Code
//
//  Created by Иван Семикин on 22/02/2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var coordinator = NavigationCoordinator.shared
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            VStack {
                BottomNavigationBarView()
            }
            .navigationDestination(for: AppPage.self) { page in
                switch page {
                case .home:
                    HomeView()
                case .enterData:
                    EnterDataView()
                case .preload(let data):
                    PreloadPersonaCodeView(personaCode: data)
                case .personaCode(let model, let isFromPreload):
                    PersonaCodeView(personaCodeData: model, isFromPreload: isFromPreload)
                case .affirmation:
                    AffirmationsView()
                case .history:
                    HistoryView()
                case .settings:
                    SettingsView()
                case .helpInfo:
                    HelpInfoView()
                }
            }
            .sheet(item: $coordinator.activeModal) { modal in
                switch modal {
                case .purchase(let personaCode):
                    PurchaseModalView(personaCode: personaCode)
                case .reminderPicker(let reminderType):
                    ReminderPickerView(reminderType: reminderType)
                        .environmentObject(AffirmationsViewModel.shared)
                        .presentationDetents([.fraction(0.5)])
                        .presentationDragIndicator(.visible)
                case .datePicker:
                    if let viewModel = coordinator.enterDataViewModel {
                        DatePickerModalView(enterDataViewModel: viewModel)
                            .presentationDetents([.fraction(0.35)])
                            .presentationDragIndicator(.visible)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(BackgroundView())
        }
        .environmentObject(coordinator)
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
