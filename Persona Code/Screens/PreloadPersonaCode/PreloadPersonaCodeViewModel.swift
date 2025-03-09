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
    @Published var statusText: String = localizedString("Retrieving your persona code . . .")
    @Published var loadWasFinished: Bool = false
    
    private var totalDuration: TimeInterval = 20.0
    private let coordinator = NavigationCoordinator.shared
    
    func savePersonaCode(personaCode: ShortPersonaCodeData) {
        StorageManager.shared.add(shortPersonaCodeData: personaCode)
    }
    
    // Начинает загрузку прогресса
    func startLoading(for personaCode: ShortPersonaCodeData) {
        progress = 0.0
        let steps = Int.random(in: 15...25)
        let delays = generateRandomDelays(totalDuration: totalDuration, steps: steps)
        
        for (index, delay) in delays.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                let preciseProgress = CGFloat(delay / self.totalDuration)
                withAnimation(.easeInOut(duration: 0.5)) {
                    self.progress = preciseProgress
                }
                
                if index == delays.count - 1 {
                    self.loadWasFinished = true
                    self.coordinator.present(.purchase(personaCode: personaCode))
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
