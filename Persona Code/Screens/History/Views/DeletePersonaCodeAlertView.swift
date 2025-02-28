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
            "Удалить Код Личности?",
            isPresented: $isPresented,
            actions: {
                Button("Удалить", role: .destructive, action: onDelete)
                Button("Отмена", role: .cancel) {}
            },
            message: {
                Text("Вы уверены, что хотите удалить Код Личности \(personaCode?.name ?? "неизвестно") - \(personaCode?.dateOfBirthday.formattedDate() ?? "неизвестно")?")
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
