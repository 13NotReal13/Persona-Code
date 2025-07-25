//
//  EnterDataViewModel.swift
//  Persona Code
//
//  Created by Иван Семикин on 23/02/2025.
//

import Foundation

final class EnterDataViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var dateBirthday: Date = Date()
    @Published var displayedDateText: String = localizedString("Choose a Date")
    
    @Published var isNameValid: Bool = true
    @Published var isDateValid: Bool = true
    
    @MainActor
    func validateName() {
        let allowedCharacters = CharacterSet.letters
        isNameValid = name.rangeOfCharacter(from: allowedCharacters.inverted) == nil && !name.isEmpty
    }
    
    @MainActor
    func validateDate() {
        isDateValid = displayedDateText.lowercased() != localizedString("Choose a Date").lowercased()
    }
    
    func updateDisplayedDate() {
        displayedDateText = dateBirthday.formattedDate()
        isDateValid = true
    }
}
