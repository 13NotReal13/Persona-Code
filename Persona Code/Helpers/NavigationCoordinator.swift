//
//  NavigationCoordinator.swift
//  Persona Code
//
//  Created by Иван Семикин on 02/03/2025.
//

import SwiftUI

enum AppPage: Hashable {
    case home
    case enterData
    case preload(ShortPersonaCodeData)
    case personaCode(ShortPersonaCodeData, isFromPreload: Bool)
    
    case affirmation
    case history
    case settings
    case helpInfo
}

enum AppModal: Identifiable, Hashable {
    case purchase(personaCode: ShortPersonaCodeData, isFromPreloadScreen: Bool)
    case reminderPicker(type: ReminderType)
    case datePicker
    
    var id: Int { self.hashValue }
}

final class NavigationCoordinator: ObservableObject {
    @Published var path = NavigationPath()
    @Published var activeModal: AppModal? = nil
    @Published var enterDataViewModel: EnterDataViewModel? = nil
    
    static let shared = NavigationCoordinator()
    
    func push(_ page: AppPage) {
        path.append(page)
        
        switch page {
        case .enterData:
            FirebaseLogsManager.shared.logScreenShown(.enterData)
        case .preload:
            FirebaseLogsManager.shared.logScreenShown(.preload)
        case .personaCode:
            FirebaseLogsManager.shared.logScreenShown(.personaCode)
        case .affirmation:
            FirebaseLogsManager.shared.logScreenShown(.affirmations)
        case .history:
            FirebaseLogsManager.shared.logScreenShown(.history)
        case .settings:
            FirebaseLogsManager.shared.logScreenShown(.settings)
        case .helpInfo:
            FirebaseLogsManager.shared.logScreenShown(.helpInfo)
        default:
            break
        }
    }
    
    func popToRoot() {
        path = NavigationPath()
    }
    
    func pop() {
        path.removeLast()
    }
    
    func present(_ modal: AppModal) {
        activeModal = modal
        
        switch modal {
        case .purchase:
            FirebaseLogsManager.shared.logScreenShown(.purchase)
        default:
            break
        }
    }
    
    func dismissModal() {
        activeModal = nil
    }
}
