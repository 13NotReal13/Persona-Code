//
//  RestorePurchasesButtonView.swift
//  Persona Code
//
//  Created by Иван Семикин on 04/03/2025.
//

import SwiftUI

struct RestorePurchasesButtonView: View {
    var body: some View {
        Section(header: Text("Purchases")) {
            Button("Restore purchases") {
                IAPManager.shared.restorePurchases()
            }
        }
        .listRowBackground(Color.white.opacity(0.1))
    }
}

#Preview {
    RestorePurchasesButtonView()
}
