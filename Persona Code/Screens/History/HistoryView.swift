//
//  HistoryView.swift
//  Persona Code
//
//  Created by Иван Семикин on 28/02/2025.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject private var coordinator: NavigationCoordinator
    @ObservedObject private var storageManager = StorageManager.shared
    
    @State private var showDeleteAlert = false
    @State private var selectedPersonaCode: ShortPersonaCodeData? = nil
    
    var body: some View {
        ZStack {
            BackgroundView(isAnimated: false)
            ShadowBackgroundView()
            
            VStack {
                if storageManager.historyPersonaCodeData.isEmpty {
                    EmptyHistoryView()
                } else {
                    Text("Удерживайте имя, чтобы удалить запись из истории")
                        .font(.custom("CorrectionBrush", size: 10))
                        .foregroundStyle(.gray)
                    
                    ScrollView {
                        ForEach(storageManager.historyPersonaCodeData) { personaCode in
                            HistoryCardView(personaCode: personaCode) {
                                selectedPersonaCode = personaCode
                                showDeleteAlert = true
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 8)
                    }
                }
            }
            .padding(.top, 10)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    NavigationBackButtonView { coordinator.pop() }
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
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        HistoryView()
    }
}
