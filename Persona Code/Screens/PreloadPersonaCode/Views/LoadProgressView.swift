//
//  LoadProgressView.swift
//  Persona Code
//
//  Created by Иван Семикин on 23/02/2025.
//

import SwiftUI

struct LoadProgressView: View {
    @ObservedObject var viewModel: PreloadPersonaCodeViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            
            Text(viewModel.statusText)
                .customText(fontSize: 16)
            
            ProgressView(value: viewModel.progress, total: 1.0)
                .tint(.ringColor2)
        }
        .padding(.horizontal, 32)
        .frame(height: UIScreen.main.bounds.height * 0.4)
    }
}
