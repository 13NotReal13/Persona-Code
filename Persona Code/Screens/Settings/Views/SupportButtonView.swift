//
//  SupportButtonView.swift
//  Persona Code
//
//  Created by Иван Семикин on 04/03/2025.
//

import SwiftUI

struct SupportButtonView: View {
    var body: some View {
        Section(header: Text("Support")) {
            Button("Contact the Developer") {
                ReviewRequestManager.shared.showFeedbackForm()
                
                FirebaseLogsManager.shared.logButtonTapped(.contact)
            }
        }
        .listRowBackground(Color.white.opacity(0.1))
    }
}

#Preview {
    SupportButtonView()
}
