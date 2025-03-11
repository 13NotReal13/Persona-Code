//
//  AffirmationModel.swift
//  Persona Code
//
//  Created by Иван Семикин on 03/03/2025.
//

import Foundation

enum AffirmationCategoryType: String, CaseIterable, Identifiable, Codable {
    case all = "All"
    case confidence = "Confidence"
    case health = "Health"
    case finance = "Finance"
    case career = "Career"
    case relationships = "Relationships"
    
    var id: String {
        rawValue
    }
    
    var displayName: String {
        localizedString(rawValue)
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
    let id: UUID
    let text: String
    let category: AffirmationCategoryType
    var isFavorite: Bool = false

    init(text: String, category: AffirmationCategoryType) {
        self.text = text
        self.category = category
        self.id = UUID(uuidString: UUIDGenerator.shared.uuid(for: text)) ?? UUID()
    }
}

final class UUIDGenerator {
    static let shared = UUIDGenerator()

    private var uuidCache: [String: String] = [:]

    private init() {
        if let savedData = UserDefaults.standard.dictionary(forKey: "affirmationUUIDs") as? [String: String] {
            uuidCache = savedData
        }
    }

    func uuid(for text: String) -> String {
        if let existingUUID = uuidCache[text] {
            return existingUUID
        } else {
            let newUUID = UUID().uuidString
            uuidCache[text] = newUUID
            UserDefaults.standard.set(uuidCache, forKey: "affirmationUUIDs")
            return newUUID
        }
    }
}
