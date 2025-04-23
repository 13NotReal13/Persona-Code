//
//  AffirmationsListView.swift
//  Persona Code
//
//  Created by Иван Семикин on 04/03/2025.
//

import SwiftUI

struct AffirmationsListView: View {
    let affirmations: [Affirmation]
    var toggleFavorite: (Affirmation) -> Void
    
    var body: some View {
        List(affirmations) { affirmation in
            HStack {
                Text(affirmation.text)
                    .customText(fontSize: 17)
                    .lineLimit(3)
                
                Spacer()
                
                Button {
                    toggleFavorite(affirmation)
                } label: {
                    Image(systemName: affirmation.isFavorite ? "star.fill" : "star")
                        .foregroundColor(affirmation.isFavorite ? .brown : .gray)
                }
            }
            .padding()
            .listRowInsets(
                EdgeInsets(
                    top: 4,
                    leading: 16,
                    bottom: 4,
                    trailing: 16
                )
            )
            .listRowBackground(Color.clear)
            .background(Color.white.opacity(0.1))
            .cornerRadius(radius: 10, corners: .allCorners)
        }
        .scrollContentBackground(.hidden)
        .listStyle(PlainListStyle())
    }
}

#Preview {
    AffirmationsListView(
        affirmations: AffirmationsViewModel.shared.filteredAffirmations,
        toggleFavorite: AffirmationsViewModel.shared.toggleFavorite(for:)
    )
}
