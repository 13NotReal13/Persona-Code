//
//  SupportButtonView.swift
//  Persona Code
//
//  Created by Иван Семикин on 04/03/2025.
//

import SwiftUI

struct SupportButtonView: View {
    var body: some View {
        Section(header: Text("Поддержка")) {
            Button("Связаться с разработчиком") {
                ReviewRequestManager.shared.showFeedbackForm()
            }
        }
        .listRowBackground(Color.white.opacity(0.1))
    }
}

#Preview {
    SupportButtonView()
}
