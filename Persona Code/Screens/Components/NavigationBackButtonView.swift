//
//  NavigationBackButtonView.swift
//  Persona Code
//
//  Created by Иван Семикин on 23/02/2025.
//

import SwiftUI

struct NavigationBackButtonView: View {
    let dismiss: () -> Void
    
    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .customText(fontSize: 17)
        }
    }
}
