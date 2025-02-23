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
                BackgroundView()
                
                BottomNavigationBarView()
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Код Личности")
                        .customText(fontSize: 32)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
