//
//  EnterDataFormView.swift
//  Persona Code
//
//  Created by Иван Семикин on 23/02/2025.
//

import SwiftUI

struct EnterDataFormView: View {
    @ObservedObject var enterDataViewModel: EnterDataViewModel
    
    var body: some View {
        VStack(spacing: 8) {
            NameTextFieldView(
                name: $enterDataViewModel.name,
                isNameValid: $enterDataViewModel.isNameValid,
                validateName: { enterDataViewModel.validateName() }
            )
            
            DatePickerView(enterDataViewModel: enterDataViewModel)
        }
    }
}

#Preview {
    ZStack {
        BackgroundView()
        
        VStack {
            Spacer()
            
            EnterDataFormView(enterDataViewModel: EnterDataViewModel())
        }
    }
}
