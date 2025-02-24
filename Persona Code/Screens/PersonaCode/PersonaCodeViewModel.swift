//
//  PersonaCodeViewModel.swift
//  Persona Code
//
//  Created by Иван Семикин on 24/02/2025.
//

import Foundation

final class PersonaCodeViewModel: ObservableObject {
    @Published var selectedSection = 1
    @Published var selectedSectionForLeftButtons = 1
    @Published var isMenuOpen = false
    @Published var showShareSheet: Bool = false
    
    @Published var shareItems: [Any] = []
    
    func generatePDF(personaCodeModel: PersonaCodeModel) {
        let pdfManager = PDFManager()
        if let pdfURL = pdfManager.savePDF(matrixData: personaCodeModel) {
            DispatchQueue.main.async {
                self.shareItems = [pdfURL]
                self.showShareSheet = true
            }
        } else {
            FirebaseLogManager.shared.logError(
                message: "Failed to generate PDF file",
                details: "Error occurred while saving PDF for matrix with name '\(personaCodeData.name)' and date of birth '\(personaCodeData.dateOfBirthday)'"
            )
        }
    }
}
