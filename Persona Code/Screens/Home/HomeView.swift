//
//  HomeView.swift
//  Persona Code
//
//  Created by Иван Семикин on 22/02/2025.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView(isAnimated: false)
                
                BottomNavigationBarView()
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    CustomNavigationTitleView(title: "Код Личности")
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
