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
    
    var personaCode: CodeInfo
    var pathOfDevelopment: CodeInfo
    var communication: CodeInfo
    var finances: CodeInfo
    var career: CodeInfo
    var resourceState: CodeInfo
    var strengths: CodeInfo
    var riskZone: CodeInfo
    var selfDevelopment: CodeInfo
    var innerBalance: CodeInfo
    var lifeGoals: CodeInfo
    var experienceAndEvolution: CodeInfo
    
    var allCodes: [CodeInfo] {
        return [
            personaCode,
            pathOfDevelopment,
            communication,
            finances,
            career,
            resourceState,
            strengths,
            riskZone,
            selfDevelopment,
            innerBalance,
            lifeGoals,
            experienceAndEvolution
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
