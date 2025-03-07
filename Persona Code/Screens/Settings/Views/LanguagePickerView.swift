//
//  LanguagePickerView.swift
//  Persona Code
//
//  Created by Иван Семикин on 04/03/2025.
//

import SwiftUI

struct LanguagePickerView: View {
    @EnvironmentObject private var viewModel: SettingsViewModel
    
    var body: some View {
        Section(header: Text("Language")) {
            Picker("Язык интерфейса", selection: $viewModel.currentLanguage) {
                Text("English").tag("en")
                Text("Russian").tag("ru")
                Text("Polish").tag("pl")
            }
            .onChange(of: viewModel.currentLanguage) { newLanguage in
                viewModel.changeLanguage(to: newLanguage)
            }
        }
        .listRowBackground(Color.white.opacity(0.1))
    }
}

#Preview {
    LanguagePickerView()
        .environmentObject(SettingsViewModel.shared)
}
