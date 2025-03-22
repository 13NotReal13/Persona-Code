//
//  EnterDataView.swift
//  Persona Code
//
//  Created by Иван Семикин on 23/02/2025.
//

import SwiftUI

struct EnterDataView: View {
    @StateObject var enterDataViewModel = EnterDataViewModel()
    
    @EnvironmentObject private var coordinator: NavigationCoordinator
    
    var body: some View {
        ZStack {
            BackgroundView(isShadow: true)
            
            VStack {
                Spacer()
                
                EnterDataFormView(enterDataViewModel: enterDataViewModel)
                
                NextButtonView(viewModel: enterDataViewModel)
                
                Spacer()
                
                Spacer()
            }
        }
        .ignoresSafeArea(.keyboard)
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .sheet(isPresented: $enterDataViewModel.isDatePickerPresented) {
            DatePickerModalView(enterDataViewModel: enterDataViewModel)
                .preferredColorScheme(.light)
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                NavigationBackButtonView { coordinator.pop() }
            }
            
            ToolbarItem(placement: .principal) {
                CustomNavigationTitleView(title: localizedString("Data Entry"))
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    EnterDataView()
}
