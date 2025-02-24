//
//  HelpInfoView.swift
//  DestinyMatrix
//
//  Created by Иван Семикин on 01/12/2024.
//

import SwiftUI

struct HelpInfoView: View {
    @Environment(\.presentationMode) var presentationMode
    
    private let categories = HelpInfoViewModel().categories
    
    var body: some View {
        NavigationView {
            ZStack {
                AnimatedStarryBackgroundView()
                ShadowBackgroundView()
                
                VStack(alignment: .center) {
                    CustomSpacerView(height: 0.01)
                    
                    HelpInfoCategoriesView(categories: categories)
                        .padding(.top, -16)
                    
                    Button(action: {
                        if let url = URL(string: "https://13notreal13.github.io/privacy-policy-destiny-matrix/privacy.html") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        Text("Политика конфиденциальности")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                    .padding()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    CustomBackButtonView { presentationMode.wrappedValue.dismiss() }
                }
                
                ToolbarItem(placement: .principal) {
                    CustomNavigationTitleView(title: "Содержание")
                }
            }
            .onAppear {
                FirebaseLogManager.shared.logScreenView(screenName: "help_info")
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    HelpInfoView()
}
