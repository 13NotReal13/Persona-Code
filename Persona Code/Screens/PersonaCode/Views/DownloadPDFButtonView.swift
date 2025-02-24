//
//  DownloadPDFButtonView.swift
//  DestinyMatrix
//
//  Created by Иван Семикин on 24/12/2024.
//

import SwiftUI

struct DownloadPDFButtonView: View {
    @ObservedObject var viewModel: PersonaCodeViewModel
    let matrixData: MatrixData
    
    var body: some View {
        Button {
            viewModel.generatePDF(matrixData: matrixData)
            FirebaseLogManager.shared.logSharePDFFile()
        } label: {
            HStack {
                Image(systemName: "square.and.arrow.down")
                Text("Скачать .pdf")
            }
            .customText(fontSize: 17, textColor: .white)
        }
    }
}
