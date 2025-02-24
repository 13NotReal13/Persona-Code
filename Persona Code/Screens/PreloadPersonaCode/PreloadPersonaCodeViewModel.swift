//
//  PreloadPersonaCodeViewModel.swift
//  Persona Code
//
//  Created by Иван Семикин on 23/02/2025.
//

import Foundation
import SwiftUI

final class PreloadPersonaCodeViewModel: ObservableObject {
    @Published var progress: CGFloat = 0.0
    @Published var statusText: String = "Получаю ваш код личности..."
    @Published var loadWasFinished: Bool = false
    @Published var showPurchaseModal: Bool = false
    
    private var totalDuration: TimeInterval = 25.0
    
    func saveMatrix(personaCode: ShortPersonaCodeData) {
        StorageManager().add(shortPersonaCodeData: personaCode)
    }
    
    // Начинает загрузку прогресса
    func startLoading() {
        progress = 0.0
        let steps = Int.random(in: 15...30)
        let delays = generateRandomDelays(totalDuration: totalDuration, steps: steps)
        
        for (index, delay) in delays.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                let preciseProgress = CGFloat(delay / self.totalDuration)
                withAnimation(.easeInOut(duration: 0.5)) {
                    self.progress = preciseProgress
                }
                
                if index == delays.count - 1 {
                    self.loadWasFinished = true
                    self.showPurchaseModal = true
                }
            }
        }
    }
    
    // Генерация случайных задержек для анимации прогресса
    private func generateRandomDelays(totalDuration: TimeInterval, steps: Int) -> [TimeInterval] {
        var delays: [TimeInterval] = []
        var accumulatedTime: TimeInterval = 0.0
        
        for i in 0..<steps {
            let remainingSteps = steps - i
            let remainingTime = totalDuration - accumulatedTime
            let stepDelay = Double.random(in: 0.1...(remainingTime / Double(remainingSteps)))
            
            accumulatedTime += stepDelay
            delays.append(accumulatedTime)
        }
        
        if let lastIndex = delays.indices.last {
            delays[lastIndex] = totalDuration
        }
        
        return delays
    }
}
