//
//  PersonalDataView.swift
//  DestinyMatrix
//
//  Created by Иван Семикин on 09/12/2024.
//

import SwiftUI

struct PersonalTitleView: View {
    @State var matrixData: MatrixData
    
    var body: some View {
        HStack {
            Text(matrixData.name)
            Text(" - ")
            Text(matrixData.dateOfBirthday.formattedDate())
        }
        .customText(fontSize: 24, textColor: .white)
        .padding(.horizontal)
        .padding(.top, 8)
        .frame(maxWidth: .infinity)
    }
}
