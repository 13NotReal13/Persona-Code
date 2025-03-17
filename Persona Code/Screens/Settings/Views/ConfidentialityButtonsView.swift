//
//  ConfidentialityButtonsView.swift
//  Persona Code
//
//  Created by Иван Семикин on 04/03/2025.
//

import SwiftUI

struct ConfidentialityButtonsView: View {
    var body: some View {
        Section(header: Text("Privacy")) {
            Button("Privacy Policy") {
                if let url = URL(string: "https://13notreal13.github.io/privacy-policy-persona-code/privacy.html") {
                    UIApplication.shared.open(url)
                }
            }
            Button("Terms of Use") {
                if let url = URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/") {
                    UIApplication.shared.open(url)
                }
            }
        }
        .listRowBackground(Color.white.opacity(0.1))
    }
}

#Preview {
    ConfidentialityButtonsView()
}
