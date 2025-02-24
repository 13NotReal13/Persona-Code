//
//  NextButtonView.swift
//  Persona Code
//
//  Created by Иван Семикин on 23/02/2025.
//

import SwiftUI

struct NextButtonView: View {
    @ObservedObject var enterDataViewModel: EnterDataViewModel
    
    var body: some View {
        NavigationLink(
            destination: PreloadPersonaCodeView(
                personaCode: ShortPersonaCodeData(
                name: enterDataViewModel.name,
                dateOfBirthday: enterDataViewModel.dateBirthday,
                dateCreationPersonaCode: .now)
            ),
            isActive: $enterDataViewModel.canNavigate
        ) {
            Button {
                enterDataViewModel.validateName()
                enterDataViewModel.validateDate()
                
                if enterDataViewModel.isNameValid && enterDataViewModel.isDateValid {
                    enterDataViewModel.canNavigate = true
                }
            } label: {
                Text("Далее")
                    .customText(fontSize: 16)
                    .customButtonStyle(width: UIScreen.main.bounds.width * 0.4, shape: .capsule)
                    .padding(.top, 16)
            }
        }
    }
}

#Preview {
    NextButtonView(enterDataViewModel: EnterDataViewModel())
}
