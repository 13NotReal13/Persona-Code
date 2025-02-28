//
//  BottomNavigationBarView.swift
//  Persona Code
//
//  Created by Иван Семикин on 23/02/2025.
//

import SwiftUI

struct BottomNavigationBarView: View {
    var body: some View {
        VStack {
            Spacer()
            
            NavigationLink {
                EnterDataView()
            } label: {
                Text("Получить Код")
                    .customText(fontSize: 17)
                    .customButtonStyle(width: UIScreen.main.bounds.width * 0.65, shape: .capsule)
            }
            
            NavigationLink {
                EmptyView()
            } label: {
                Text("Аффирмации")
                    .customText(fontSize: 17)
                    .customButtonStyle(width: UIScreen.main.bounds.width * 0.65, shape: .capsule)
            }
            
            NavigationLink {
                HistoryView()
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
                HelpInfoView()
            } label: {
                Text("Как это работает?")
                    .customText(fontSize: 17)
                    .customButtonStyle(width: UIScreen.main.bounds.width * 0.5, shape: .capsule)
            }
        }
    }
}

#Preview {
    BottomNavigationBarView()
}
