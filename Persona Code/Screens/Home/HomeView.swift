//
//  HomeView.swift
//  Persona Code
//
//  Created by Иван Семикин on 22/02/2025.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                
                VStack {
                    
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Код Личности")
                        .font(.system(size: 32))
                        .bold()
                        .foregroundStyle(.white)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
