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
            ZStack {
                BackgroundView()
                
                BottomNavigationBarView()
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    CustomNavigationTitleView(title: "Код Личности")
                }
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
                    EmptyView()
                case .history:
                    HistoryView()
                case .settings:
                    EmptyView()
                case .helpInfo:
                    HelpInfoView()
                }
            }
            .sheet(item: $coordinator.activeModal) { modal in
                switch modal {
                case .purchase(let personaCode):
                    PurchaseModalView(personaCode: personaCode)
                }
            }
        }
        .environmentObject(coordinator)
    }
}

#Preview {
    HomeView()
}
