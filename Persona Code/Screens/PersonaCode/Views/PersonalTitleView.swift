//
//  PersonalDataView.swift
//  Persona Code
//
//  Created by Иван Семикин on 24/02/2025.
//

import SwiftUI

struct PersonalTitleView: View {
    @State var personaCodeData: PersonaCodeModel
    
    var body: some View {
        HStack {
            Text(personaCodeData.name)
            Text(" - ")
            Text(personaCodeData.dateOfBirthday.formattedDate())
        }
        .customText(fontSize: 24)
        .padding(.horizontal)
        .padding(.top, 8)
        .frame(maxWidth: .infinity)
    }
}
