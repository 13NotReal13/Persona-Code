//
//  ShareSheet.swift
//  Persona Code
//
//  Created by Иван Семикин on 24/02/2025.
//

import Foundation
import SwiftUI

// View для открытия окна "Поделиться"
struct ShareSheet: UIViewControllerRepresentable {
    var items: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
