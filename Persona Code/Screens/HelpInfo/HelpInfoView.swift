//
//  HelpInfoView.swift
//  DestinyMatrix
//
//  Created by Иван Семикин on 01/12/2024.
//

import SwiftUI

struct HelpInfoView: View {
    @Environment(\.dismiss) var dismiss
    
    private let categories = HelpInfoViewModel().categories
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                
                VStack(alignment: .center) {
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
                    NavigationBackButtonView { dismiss() }
                }
                
                ToolbarItem(placement: .principal) {
                    CustomNavigationTitleView(title: "Содержание")
                }
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    HelpInfoView()
}
