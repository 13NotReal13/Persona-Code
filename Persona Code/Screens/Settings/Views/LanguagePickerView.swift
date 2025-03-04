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
        Section(header: Text("Язык")) {
            Picker("Язык интерфейса", selection: $viewModel.selectedLanguage) {
                ForEach(viewModel.availableLanguages, id: \.self) { language in
                    Text(language).tag(language)
                }
            }
        }
        .listRowBackground(Color.white.opacity(0.1))
    }
}

#Preview {
    LanguagePickerView()
        .environmentObject(SettingsViewModel.shared)
}
