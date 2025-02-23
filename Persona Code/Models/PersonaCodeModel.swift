//
//  PersonaCodeModel.swift
//  Persona Code
//
//  Created by Иван Семикин on 23/02/2025.
//

import Foundation

struct PersonaCodeModel: Hashable {
    var name: String
    var dateOfBirthday: Date
    
    var destinyNumber: EnergyInfo // Число Судьбы
    var lifePath: EnergyInfo // Жизненный Путь
    var relationships: EnergyInfo // Отношения
    var finances: EnergyInfo // Деньги и Финансы
    var career: EnergyInfo // Карьера и Профессия
    var health: EnergyInfo // Здоровье
    var talents: EnergyInfo // Таланты и Способности
    var challenges: EnergyInfo // Испытания и Препятствия
    var personalGrowth: EnergyInfo // Личностный Рост
    var innerSelf: EnergyInfo // Внутренний Мир
    var purpose: EnergyInfo // Предназначение
    var karmicLessons: EnergyInfo // Кармические Уроки
    
    var allEnergies: [EnergyInfo] {
        return [
            destinyNumber,
            lifePath,
            relationships,
            finances,
            career,
            health,
            talents,
            challenges,
            personalGrowth,
            innerSelf,
            purpose,
            karmicLessons
        ]
    }
    
    var energyNumbers: [Int] {
        return allEnergies.map { $0.energyNumber }
    }
}

typealias EnergyDictionary = [Int: EnergyInfo]

struct EnergyInfo: Hashable {
    let energyNumber: Int
    let title: String
    let subcategories: [Subcategory]
}

struct Subcategory: Hashable {
    let title: String
    let shortDescription: String
    var mainDescription: String = ""
}
