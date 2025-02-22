//
//  HomeView.swift
//  Persona Code
//
//  Created by Иван Семикин on 22/02/2025.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            RotatingNumberRingView(sizeOfRing: 0.8, fontSize: 21, direction: .left)
            RotatingNumberRingView(sizeOfRing: 0.65, fontSize: 18, direction: .right)
            RotatingNumberRingView(sizeOfRing: 0.5, fontSize: 15, direction: .left)
        }
    }
}

#Preview {
    HomeView()
}
