//
//  DeletePersonaCodeAlertView.swift
//  Persona Code
//
//  Created by Иван Семикин on 28/02/2025.
//

import SwiftUI

struct DeletePersonaCodeAlertView: ViewModifier {
    @Binding var isPresented: Bool
    var personaCode: ShortPersonaCodeData?
    var onDelete: () -> Void
    
    func body(content: Content) -> some View {
        content.alert(
            "Delete Persona Code?",
            isPresented: $isPresented,
            actions: {
                Button("Delete", role: .destructive, action: onDelete)
                Button("Cancel", role: .cancel) {}
            },
            message: {
                Text("Are you sure you want to delete the Persona Code \(personaCode?.name ?? "неизвестно") - \(personaCode?.dateOfBirthday.formattedDate() ?? "неизвестно")?")
            }
        )
    }
}

extension View {
    func deletePersonaCodeAlert(
        isPresented: Binding<Bool>,
        personaCode: ShortPersonaCodeData?,
        onDelete: @escaping () -> Void
    ) -> some View {
        self.modifier(DeletePersonaCodeAlertView(
            isPresented: isPresented,
            personaCode: personaCode,
            onDelete: onDelete
        ))
    }
}
