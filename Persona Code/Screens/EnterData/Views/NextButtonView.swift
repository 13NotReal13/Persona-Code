//
//  NextButtonView.swift
//  Persona Code
//
//  Created by Иван Семикин on 23/02/2025.
//

import SwiftUI

struct NextButtonView: View {
    @ObservedObject var viewModel: EnterDataViewModel
    
    @EnvironmentObject private var coordinator: NavigationCoordinator
    
    var body: some View {
        VStack {
            Button {
                viewModel.validateName()
                viewModel.validateDate()
                
                if viewModel.isNameValid && viewModel.isDateValid {
                    let shortPersonaCode = ShortPersonaCodeData(
                        name: viewModel.name,
                        dateOfBirthday: viewModel.dateBirthday,
                        dateCreationPersonaCode: .now
                    )
                    
                    coordinator.push(.preload(shortPersonaCode))
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
    NextButtonView(viewModel: EnterDataViewModel())
}
