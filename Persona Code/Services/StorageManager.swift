//
//  StorageManager.swift
//  Persona Code
//
//  Created by Иван Семикин on 23/02/2025.
//

import Foundation
import SwiftUI

struct ShortPersonaCodeData: Codable, Hashable, Identifiable {
    var id: UUID = UUID()
    var isFullVersion: Bool? = true
    
    let name: String
    let dateOfBirthday: Date
    let dateCreationPersonaCode: Date
}

extension ShortPersonaCodeData {
    var isFull: Bool {
        isFullVersion ?? true // по умолчанию считаем, что это была полная версия
    }
}

final class StorageManager: ObservableObject {
    static let shared = StorageManager()
    
    @AppStorage("historyPersonaCodeData") private var storedData: String = ""
    @Published var historyPersonaCodeData: [ShortPersonaCodeData] = []
    
    private init() {
        load()
    }
    
    func add(shortPersonaCodeData: ShortPersonaCodeData) {
        historyPersonaCodeData.append(shortPersonaCodeData)
        historyPersonaCodeData.sort(by: { $0.dateCreationPersonaCode > $1.dateCreationPersonaCode })
        save()
    }
    
    func updateToFullVersion(shortPersonaCodeData: ShortPersonaCodeData) {
        if let index = historyPersonaCodeData.firstIndex(
            where: {
                $0.name == shortPersonaCodeData.name
                && $0.dateOfBirthday == shortPersonaCodeData.dateOfBirthday
                && $0.dateCreationPersonaCode == shortPersonaCodeData.dateCreationPersonaCode
            }) {
            historyPersonaCodeData[index].isFullVersion = true
            save()
            
            FirebaseLogsManager.shared.logDemoUpgradedToFull(
                name: shortPersonaCodeData.name,
                dateBirth: shortPersonaCodeData.dateOfBirthday.formattedDate()
            )
        }
    }
    
    func delete(shortPersonaCodeData: ShortPersonaCodeData) {
        historyPersonaCodeData.removeAll { $0.id == shortPersonaCodeData.id }
        save()
    }
    
    private func load() {
        guard let data = storedData.data(using: .utf8),
              let decodedData = try? JSONDecoder().decode([ShortPersonaCodeData].self, from: data)
        else {
            historyPersonaCodeData = []
            return
        }
        historyPersonaCodeData = decodedData
    }
    
    private func save() {
        if let encodedData = try? JSONEncoder().encode(historyPersonaCodeData) {
            storedData = String(data: encodedData, encoding: .utf8) ?? ""
        }
    }
}
