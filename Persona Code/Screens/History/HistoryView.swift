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
        VStack {
            if storageManager.historyPersonaCodeData.isEmpty {
                EmptyHistoryView()
            } else {
                Text("Hold the name to delete the entry from history")
                    .font(.custom(CustomFont.interVariable.rawValue, size: 10))
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
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .padding(.top, 10)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                NavigationBackButtonView { coordinator.pop() }
            }
            
            ToolbarItem(placement: .principal) {
                CustomNavigationTitleView(title: localizedString("History"))
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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(BackgroundView(shadowLevel: .high))
    }
}

#Preview {
    NavigationStack {
        HistoryView()
    }
}
