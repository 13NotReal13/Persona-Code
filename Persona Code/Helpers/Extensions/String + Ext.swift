//
//  String + Ext.swift
//  Persona Code
//
//  Created by Иван Семикин on 23/02/2025.
//

import Foundation

extension String {
    var isCyrillicOnly: Bool {
        let pattern = "^[А-Яа-яЁё]+$"
        return self.range(of: pattern, options: .regularExpression) != nil
    }
}
