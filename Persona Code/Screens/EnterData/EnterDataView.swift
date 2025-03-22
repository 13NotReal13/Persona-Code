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
        VStack {
            Spacer()
            Spacer()
            
            EnterDataFormView(enterDataViewModel: enterDataViewModel)
            
            NextButtonView(viewModel: enterDataViewModel)
            
            Spacer()
            Spacer()
            Spacer()
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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            BackgroundView(shadowLevel: .medium)
                .onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
        )
        .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    EnterDataView()
}
