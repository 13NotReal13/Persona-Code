//
//  LocalizedString.swift
//  Persona Code
//
//  Created by Иван Семикин on 09/03/2025.
//

import Foundation

func localizedString(_ key: String) -> String {
    let selectedLanguage = UserDefaults.standard.string(forKey: "currentLanguage") ?? "en"
    guard let path = Bundle.main.path(forResource: selectedLanguage, ofType: "lproj"),
          let bundle = Bundle(path: path) else {
        return NSLocalizedString(key, comment: "")
    }
    return bundle.localizedString(forKey: key, value: nil, table: nil)
}
