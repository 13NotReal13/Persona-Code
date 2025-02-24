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
            BackgroundView(isAnimated: false)
            
            ShadowBackgroundView()
            
            VStack {
                Spacer()
                
                EnterDataFormView(enterDataViewModel: enterDataViewModel)
                
                NextButtonView(enterDataViewModel: enterDataViewModel)
            }
        }
        .onTapGesture {
            UIApplication.shared.connectedScenes
                .compactMap { ($0 as? UIWindowScene)?.keyWindow }
                .first?
                .endEditing(true)
        } 
        .sheet(isPresented: $enterDataViewModel.isDatePickerPresented) {
            DatePickerModalView(enterDataViewModel: enterDataViewModel)
                .preferredColorScheme(.light)
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                NavigationBackButtonView { dismiss() }
            }
            
            ToolbarItem(placement: .principal) {
                CustomNavigationTitleView(title: "Ввод Данных")
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    EnterDataView()
}
