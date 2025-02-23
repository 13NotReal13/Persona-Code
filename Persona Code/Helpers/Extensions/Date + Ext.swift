//
//  Date + Ext.swift
//  Persona Code
//
//  Created by Иван Семикин on 23/02/2025.
//

import Foundation

extension Date {
    func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.locale = Locale(identifier: "ru")
        
        return formatter.string(from: self)
    }
}
