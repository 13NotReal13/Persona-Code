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
    
    var destinyNumber: CodeInfo // Число Судьбы
    var lifePath: CodeInfo // Жизненный Путь
    var relationships: CodeInfo // Отношения
    var finances: CodeInfo // Деньги и Финансы
    var career: CodeInfo // Карьера и Профессия
    var health: CodeInfo // Здоровье
    var talents: CodeInfo // Таланты и Способности
    var challenges: CodeInfo // Испытания и Препятствия
    var personalGrowth: CodeInfo // Личностный Рост
    var innerSelf: CodeInfo // Внутренний Мир
    var purpose: CodeInfo // Предназначение
    var karmicLessons: CodeInfo // Кармические Уроки
    
    var allCodes: [CodeInfo] {
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
    
    var codeNumbers: [Int] {
        return allCodes.map { $0.codeNumber }
    }
}

typealias CodeDictionary = [Int: CodeInfo]

struct CodeInfo: Hashable {
    let codeNumber: Int
    let title: String
    let subcategories: [Subcategory]
}

struct Subcategory: Hashable {
    let title: String
    let shortDescription: String
    var mainDescription: String = ""
}
