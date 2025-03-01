//
//  BottomNavigationBarView.swift
//  Persona Code
//
//  Created by Иван Семикин on 23/02/2025.
//

import SwiftUI

struct BottomNavigationBarView: View {
    @State private var navigateToGetCode = false
    @State private var navigateToAffirmations = false
    @State private var navigateToHistory = false
    @State private var navigateToSettings = false
    @State private var navigateToHelpInfoView = false
    
    var body: some View {
        VStack {
            Spacer()
            
            Button {
                navigateToGetCode = true
            } label: {
                Text("Получить Код")
                    .customText(fontSize: 17)
                    .customButtonStyle(width: UIScreen.main.bounds.width * 0.65, shape: .capsule)
            }
            
            Button {
                navigateToAffirmations = true
            } label: {
                Text("Аффирмации")
                    .customText(fontSize: 17)
                    .customButtonStyle(width: UIScreen.main.bounds.width * 0.65, shape: .capsule)
            }
            
            Button {
                navigateToHistory = true
            } label: {
                Text("История")
                    .customText(fontSize: 17)
                    .customButtonStyle(width: UIScreen.main.bounds.width * 0.6, shape: .capsule)
            }
            
            Button {
                navigateToSettings = true
            } label: {
                Text("Настройки")
                    .customText(fontSize: 17)
                    .customButtonStyle(width: UIScreen.main.bounds.width * 0.55, shape: .capsule)
            }
            
            Button {
                navigateToHelpInfoView = true
            } label: {
                Text("Как это работает?")
                    .customText(fontSize: 17)
                    .customButtonStyle(width: UIScreen.main.bounds.width * 0.5, shape: .capsule)
            }
        }
        .padding()
        .navigationDestination(isPresented: $navigateToGetCode) {
            EnterDataView()
        }
        .navigationDestination(isPresented: $navigateToAffirmations) {
            EmptyView()
        }
        .navigationDestination(isPresented: $navigateToHistory) {
            HistoryView()
        }
        .navigationDestination(isPresented: $navigateToSettings) {
            EmptyView()
        }
        .navigationDestination(isPresented: $navigateToHelpInfoView) {
            HelpInfoView()
        }
    }
}

#Preview {
    BottomNavigationBarView()
}
