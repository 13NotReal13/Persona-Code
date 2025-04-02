//
//  MusicToogleView.swift
//  Persona Code
//
//  Created by Иван Семикин on 02/04/2025.
//

import SwiftUI

struct MusicToogleView: View {
    @State private var isMusicEnabled = AudioManager.shared.isMusicEnabled
    
    var body: some View {
        Section(header: Text("Music")) {
            Toggle("Background Music", isOn: $isMusicEnabled)
                .tint(.brown)
                .onChange(of: isMusicEnabled) { newValue in
                    AudioManager.shared.isMusicEnabled = newValue
                    FirebaseLogsManager.shared.logMusicToogle(isEnabled: newValue)
                }
        }
        .listRowBackground(Color.white.opacity(0.1))
    }
}

#Preview {
    MusicToogleView()
}
