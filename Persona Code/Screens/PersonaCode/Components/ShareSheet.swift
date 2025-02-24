//
//  ShareSheet.swift
//  DestinyMatrix
//
//  Created by Иван Семикин on 24/12/2024.
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
