//
//  DownloadPDFButtonView.swift
//  Persona Code
//
//  Created by Иван Семикин on 24/02/2025.
//

import SwiftUI

struct DownloadPDFButtonView: View {
    @ObservedObject var viewModel: PersonaCodeViewModel
    let personaCodeData: PersonaCodeModel
    
    var body: some View {
        Button {
            viewModel.generatePDF(personaCodeData: personaCodeData)
        } label: {
            HStack {
                Image(systemName: "square.and.arrow.down")
                Text("Download .pdf")
            }
            .customText(fontSize: 17)
        }
    }
}
