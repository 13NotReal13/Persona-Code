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
    
    private let categories = HelpInfoViewModel().categories
    
    var body: some View {
        ZStack {
            BackgroundView(isAnimated: false)
            
            ShadowBackgroundView()
            
            VStack(alignment: .center) {
                Picker(selection: $selectedTab) {
                    Text("Как это работает?").tag(0)
                    Text("Содержимое").tag(1)
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
            .padding(.horizontal)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    NavigationBackButtonView { coordinator.pop() }
                }
                
                ToolbarItem(placement: .principal) {
                    CustomNavigationTitleView(title: "Информация")
                }
            }
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    HelpInfoView()
        .preferredColorScheme(.dark)
}
