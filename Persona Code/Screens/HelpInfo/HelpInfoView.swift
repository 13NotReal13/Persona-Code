//
//  HelpInfoView.swift
//  Persona Code
//
//  Created by Иван Семикин on 24/02/2025.
//

import SwiftUI

struct HelpInfoView: View {
    @EnvironmentObject private var coordinator: NavigationCoordinator
    @State private var selectedTab = 0
    
    private var categories: [CodeInfo] {
        switch UserDefaults.standard.string(forKey: "currentLanguage") {
        case "ru":
            return InfoContentData_RU().categories
        case "pl":
            return InfoContentData_PL().categories
        default:
            return InfoContentData_EN().categories
        }
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Picker(selection: $selectedTab) {
                Text("How does it work?").tag(0)
                Text("Content").tag(1)
            } label: {
                Text("")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            if selectedTab == 0 {
                HowItWorksView()
            } else {
                HelpInfoCategoriesView(categories: categories)
            }
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .padding(.horizontal)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                NavigationBackButtonView { coordinator.pop() }
            }
            
            ToolbarItem(placement: .principal) {
                CustomNavigationTitleView(title: localizedString("Information"))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(BackgroundView(shadowLevel: .high))
    }
}

#Preview {
    HelpInfoView()
        .preferredColorScheme(.dark)
}
