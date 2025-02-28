//
//  HistoryView.swift
//  Persona Code
//
//  Created by Иван Семикин on 28/02/2025.
//

import SwiftUI

struct HistoryView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var storageManager = StorageManager()
    
    @State private var showDeleteAlert = false
    @State private var selectedPersonaCode: ShortPersonaCodeData? = nil
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView(isAnimated: false)
                
                ShadowBackgroundView(isHighShadowLevel: true)
                
                VStack {
                    if storageManager.historyPersonaCodeData.isEmpty {
                        EmptyHistoryView()
                    } else {
                        Text("Удерживайте имя, чтобы удалить запись из истории")
                            .font(.custom("CorrectionBrush", size: 10))
                            .foregroundStyle(.gray)
                        
                        PersonaCodeListView(
                            personaCodeList: storageManager.historyPersonaCodeData,
                            onLongPress: { personaCode in
                                selectedPersonaCode = personaCode
                                showDeleteAlert = true
                            }
                        )
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    NavigationBackButtonView { dismiss() }
                }
                
                ToolbarItem(placement: .principal) {
                    CustomNavigationTitleView(title: "История")
                }
            }
            .deletePersonaCodeAlert(
                isPresented: $showDeleteAlert,
                personaCode: selectedPersonaCode,
                onDelete: {
                    if let personaCode = selectedPersonaCode {
                        withAnimation {
                            storageManager.delete(shortPersonaCodeData: personaCode)
                        }
                    }
                }
            )
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    HistoryView()
}
