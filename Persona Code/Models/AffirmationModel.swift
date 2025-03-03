//
//  AffirmationModel.swift
//  Persona Code
//
//  Created by Иван Семикин on 03/03/2025.
//

import Foundation

enum AffirmationCategoryType: String, CaseIterable, Identifiable, Codable {
    case all = "Все"
    case confidence = "Уверенность"
    case health = "Здоровье"
    case finance = "Финансы"
    case career = "Карьера"
    case relationships = "Отношения"
    
    var id: String {
        rawValue
    }
    
    var displayName: String {
        rawValue
    }
    
    var icon: String {
        switch self {
        case .all: return "square.grid.2x2"
        case .confidence: return "bolt.fill"
        case .health: return "heart.fill"
        case .finance: return "dollarsign.circle.fill"
        case .career: return "briefcase.fill"
        case .relationships: return "heart.circle.fill"
        }
    }
}

struct Affirmation: Identifiable, Codable {
    var id = UUID()
    let text: String
    let category: AffirmationCategoryType
    var isFavorite: Bool = false
}
