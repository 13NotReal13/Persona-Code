//
//  HelpInfoView.swift
//  Persona Code
//
//  Created by Иван Семикин on 24/02/2025.
//

import SwiftUI

struct HelpInfoView: View {
    @Environment(\.dismiss) var dismiss
    
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
                
                Button(action: {
                    if let url = URL(string: "https://13notreal13.github.io/privacy-policy-destiny-matrix/privacy.html") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Политика конфиденциальности")
                        .font(.footnote)
                        .foregroundColor(.white)
                }
                .padding()
            }
            .padding(.horizontal)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    NavigationBackButtonView { dismiss() }
                }
                
                ToolbarItem(placement: .principal) {
                    CustomNavigationTitleView(title: "Содержание")
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    HelpInfoView()
        .preferredColorScheme(.dark)
}
