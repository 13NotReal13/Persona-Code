//
//  Date + Ext.swift
//  Persona Code
//
//  Created by Иван Семикин on 23/02/2025.
//

import Foundation

extension Date {
    func formattedDate() -> String {
        let currentLanguage = UserDefaults.standard.string(forKey: "currentLanguage") ?? "en"
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.locale = Locale(identifier: currentLanguage)
        
        return formatter.string(from: self)
    }
}
