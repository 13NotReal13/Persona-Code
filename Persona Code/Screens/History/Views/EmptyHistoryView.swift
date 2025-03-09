//
//  EmptyHistoryView.swift
//  Persona Code
//
//  Created by Иван Семикин on 28/02/2025.
//

import SwiftUI

struct EmptyHistoryView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("No history")
                .font(.custom(CustomFont.correctionBrush.rawValue, size: 17))
                .foregroundColor(.gray)
            Spacer()
        }
    }
}
