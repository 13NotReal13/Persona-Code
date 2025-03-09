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
    @Published var displayedDateText: String = localizedString("Choose a date")
    
    @Published var isNameValid: Bool = true
    @Published var isDateValid: Bool = true
    
    @Published var isDatePickerPresented: Bool = false
    
    @MainActor
    func validateName() {
        isNameValid = name.isCyrillicOnly
    }
    
    @MainActor
    func validateDate() {
        isDateValid = displayedDateText.lowercased() != localizedString("Choose a date").lowercased()
    }
    
    func updateDisplayedDate() {
        displayedDateText = dateBirthday.formattedDate()
        isDateValid = true
    }

    func toggleDatePicker() {
        isDatePickerPresented.toggle()
    }
}
