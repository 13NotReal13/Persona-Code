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
            Text("Нет истории")
                .font(.custom("CorrectionBrush", size: 17))
                .foregroundColor(.gray)
            Spacer()
        }
    }
}
