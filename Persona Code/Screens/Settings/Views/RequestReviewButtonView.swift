//
//  RequestReviewButtonView.swift
//  Persona Code
//
//  Created by Иван Семикин on 04/03/2025.
//

import SwiftUI

struct RequestReviewButtonView: View {
    var body: some View {
        Section(header: Text("Ratings and reviews")) {
            Button("Rate the app") {
                ReviewRequestManager.shared.requestReview()
            }
        }
        .listRowBackground(Color.white.opacity(0.1))
    }
}

#Preview {
    RequestReviewButtonView()
}
