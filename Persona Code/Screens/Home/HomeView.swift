//
//  HomeView.swift
//  Persona Code
//
//  Created by Иван Семикин on 22/02/2025.
//

import SwiftUI

final class NavigationManager: ObservableObject {
    @Published var isRootActive: Bool = false
}

struct HomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                
                VStack {
                    Spacer()
                    
                    NavigationLink {
                        EmptyView()
                    } label: {
                        Text("Получить Код")
                            .customText(fontSize: 17)
                            .customButtonStyle(width: UIScreen.main.bounds.width * 0.7, shape: .capsule)
                    }
                    
                    NavigationLink {
                        EmptyView()
                    } label: {
                        Text("Аффирмации")
                            .customText(fontSize: 17)
                            .customButtonStyle(width: UIScreen.main.bounds.width * 0.65, shape: .capsule)
                    }
                    
                    NavigationLink {
                        EmptyView()
                    } label: {
                        Text("История")
                            .customText(fontSize: 17)
                            .customButtonStyle(width: UIScreen.main.bounds.width * 0.6, shape: .capsule)
                    }
                    
                    NavigationLink {
                        EmptyView()
                    } label: {
                        Text("Настройки")
                            .customText(fontSize: 17)
                            .customButtonStyle(width: UIScreen.main.bounds.width * 0.55, shape: .capsule)
                    }
                    
                    NavigationLink {
                        EmptyView()
                    } label: {
                        Text("Как это работает?")
                            .customText(fontSize: 17)
                            .customButtonStyle(width: UIScreen.main.bounds.width * 0.5, shape: .capsule)
                    }
                }
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
