//
//  EnterDataView.swift
//  Persona Code
//
//  Created by Иван Семикин on 23/02/2025.
//

import SwiftUI

struct EnterDataView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var enterDataViewModel = EnterDataViewModel()
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack {
                Spacer()
                
                EnterDataFormView(enterDataViewModel: enterDataViewModel)
            }
        }
        .sheet(isPresented: $enterDataViewModel.isDatePickerPresented) {
            DatePickerModalView(enterDataViewModel: enterDataViewModel)
                .preferredColorScheme(.light)
        }
    }
}

#Preview {
    EnterDataView()
}
