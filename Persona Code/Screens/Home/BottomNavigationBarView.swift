//
//  BottomNavigationBarView.swift
//  Persona Code
//
//  Created by Иван Семикин on 23/02/2025.
//

import SwiftUI

struct BottomNavigationBarView: View {
    @EnvironmentObject private var coordinator: NavigationCoordinator
    
    @AppStorage("hasOpenedHowItWorks") private var hasOpenedHowItWorks: Bool = false
    @State private var howDoesItWorkIsAnimating = false
    
    var body: some View {
        VStack {
            Spacer()
            
            Button {
                coordinator.push(.enterData)
            } label: {
                Text("Persona Code")
                    .customText(fontSize: 17)
                    .customButtonStyle(width: UIScreen.main.bounds.width * 0.7, shape: .capsule)
            }
            
            Button {
                coordinator.push(.affirmation)
            } label: {
                Text("Affirmations")
                    .customText(fontSize: 17)
                    .customButtonStyle(width: UIScreen.main.bounds.width * 0.65, shape: .capsule)
            }
            
            Button {
                coordinator.push(.history)
            } label: {
                Text("History")
                    .customText(fontSize: 17)
                    .customButtonStyle(width: UIScreen.main.bounds.width * 0.6, shape: .capsule)
            }
            
            Button {
                coordinator.push(.settings)
            } label: {
                Text("Settings")
                    .customText(fontSize: 17)
                    .customButtonStyle(width: UIScreen.main.bounds.width * 0.55, shape: .capsule)
            }
            
            Button {
                hasOpenedHowItWorks = true
                coordinator.push(.helpInfo)
            } label: {
                Text("How does it work?")
                    .customText(fontSize: 17)
                    .customButtonStyle(width: UIScreen.main.bounds.width * 0.5, shape: .capsule)
                    .scaleEffect(!hasOpenedHowItWorks && howDoesItWorkIsAnimating ? 1.05 : 1)
                    .shadow(color: !hasOpenedHowItWorks ? .white.opacity(0.7) : .clear, radius: 8)
            }
        }
        .padding()
        .onAppear {
            if !hasOpenedHowItWorks {
                withAnimation(Animation.easeInOut(duration: 1).repeatForever()) {
                    howDoesItWorkIsAnimating = true
                }
            }
        }
    }
}

#Preview {
    BottomNavigationBarView()
}
