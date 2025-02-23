//
//  CustomNavigationTitleView.swift
//  Persona Code
//
//  Created by Иван Семикин on 23/02/2025.
//

import SwiftUI

struct CustomNavigationTitleView: View {
    let title: String
    
    var body: some View {
        Text(title)
            .customText(fontSize: 28)
    }
}
