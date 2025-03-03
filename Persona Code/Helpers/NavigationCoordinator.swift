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
    case personaCode(PersonaCodeModel, isFromPreload: Bool)
    
    case affirmation
    case history
    case settings
    case helpInfo
}

enum AppModal: Identifiable, Hashable {
    case purchase(personaCode: ShortPersonaCodeData)
    case reminderPicker
    
    var id: Int { self.hashValue }
}

final class NavigationCoordinator: ObservableObject {
    @Published var path = NavigationPath()
    @Published var activeModal: AppModal? = nil
    
    static let shared = NavigationCoordinator()
    
    func push(_ page: AppPage) {
        path.append(page)
    }
    
    func popToRoot() {
        path = NavigationPath()
    }
    
    func pop() {
        path.removeLast()
    }
    
    func present(_ modal: AppModal) {
        activeModal = modal
    }
    
    func dismissModal() {
        activeModal = nil
    }
}
