//
//  PersonaCodeCalculation.swift
//  Persona Code
//
//  Created by Иван Семикин on 23/02/2025.
//

import Foundation
import SwiftUI

struct PersonaCodeCalculation {
    @AppStorage("currentLanguage") var currentLanguage = "en"
    
    let name: String
    let dateOfBirthday: Date
    
    var personaCodeData: PersonaCodeModel {
        switch currentLanguage {
        case "pl":
            return PersonaCodeModel(
                name: name,
                dateOfBirthday: dateOfBirthday,
                
                personaCode: PersonaCodeCodes_RU.allCodes[getPersonaCodeValue]!,
                pathOfDevelopment: PathOfDevelopmentCodes_RU.allCodes[getPathOfDevelopmentValue]!,
                communication: CommunicationCodes_PL.allCodes[getCommunicationValue]!,
                finances: FinancesCodes_PL.allCodes[getFinancesValue]!,
                career: CareerCodes_PL.allCodes[getCareerValue]!,
                resourceState: ResourceStateCodes_RU.allCodes[getResourceStateValue]!,
                strengths: StrengthsCodes_RU.allCodes[getStrengthsValue]!,
                riskZone: RiskZoneCodes_RU.allCodes[getRiskZoneValue]!,
                selfDevelopment: SelfDevelopmentCodes_RU.allCodes[getSelfDevelopmentValue]!,
                innerBalance: InnerBalanceCodes_PL.allCodes[getInnerBalanceValue]!,
                lifeGoals: LifeGoalsCodes_PL.allCodes[getLifeGoalsValue]!,
                experienceAndEvolution: ExperienceAndEvolutionCodes_PL.allCodes[getExperienceAndEvolutionValue]!
            )
        case "ru":
            return PersonaCodeModel(
                name: name,
                dateOfBirthday: dateOfBirthday,
                
                personaCode: PersonaCodeCodes_RU.allCodes[getPersonaCodeValue]!,
                pathOfDevelopment: PathOfDevelopmentCodes_RU.allCodes[getPathOfDevelopmentValue]!,
                communication: CommunicationCodes_RU.allCodes[getCommunicationValue]!,
                finances: FinancesCodes_RU.allCodes[getFinancesValue]!,
                career: CareerCodes_RU.allCodes[getCareerValue]!,
                resourceState: ResourceStateCodes_RU.allCodes[getResourceStateValue]!,
                strengths: StrengthsCodes_RU.allCodes[getStrengthsValue]!,
                riskZone: RiskZoneCodes_RU.allCodes[getRiskZoneValue]!,
                selfDevelopment: SelfDevelopmentCodes_RU.allCodes[getSelfDevelopmentValue]!,
                innerBalance: InnerBalanceCodes_RU.allCodes[getInnerBalanceValue]!,
                lifeGoals: LifeGoalsCodes_RU.allCodes[getLifeGoalsValue]!,
                experienceAndEvolution: ExperienceAndEvolutionCodes_RU.allCodes[getExperienceAndEvolutionValue]!
            )
        default:
            return PersonaCodeModel(
                name: name,
                dateOfBirthday: dateOfBirthday,
                
                personaCode: PersonaCodeCodes_EN.allCodes[getPersonaCodeValue]!,
                pathOfDevelopment: PathOfDevelopmentCodes_EN.allCodes[getPathOfDevelopmentValue]!,
                communication: CommunicationCodes_EN.allCodes[getCommunicationValue]!,
                finances: FinancesCodes_EN.allCodes[getFinancesValue]!,
                career: CareerCodes_EN.allCodes[getCareerValue]!,
                resourceState: ResourceStateCodes_EN.allCodes[getResourceStateValue]!,
                strengths: StrengthsCodes_EN.allCodes[getStrengthsValue]!,
                riskZone: RiskZoneCodes_EN.allCodes[getRiskZoneValue]!,
                selfDevelopment: SelfDevelopmentCodes_EN.allCodes[getSelfDevelopmentValue]!,
                innerBalance: InnerBalanceCodes_EN.allCodes[getInnerBalanceValue]!,
                lifeGoals: LifeGoalsCodes_EN.allCodes[getLifeGoalsValue]!,
                experienceAndEvolution: ExperienceAndEvolutionCodes_EN.allCodes[getExperienceAndEvolutionValue]!
            )
        }
    }
    
    private let day: Int
    private let month: Int
    private let year: Int
    
    private let englishAlphabetWeights: [Character: Int] = [
        "a": 1, "b": 2, "c": 3, "d": 4, "e": 5, "f": 6, "g": 7, "h": 8, "i": 9,
        "j": 1, "k": 2, "l": 3, "m": 4, "n": 5, "o": 6, "p": 7, "q": 8, "r": 9,
        "s": 1, "t": 2, "u": 3, "v": 4, "w": 5, "x": 6, "y": 7, "z": 8
    ]
    
    private let polishAlphabetWeights: [Character: Int] = [
        "a": 1, "ą": 2, "b": 3, "c": 4, "ć": 5, "d": 6, "e": 7, "ę": 8, "f": 9,
        "g": 1, "h": 2, "i": 3, "j": 4, "k": 5, "l": 6, "ł": 7, "m": 8, "n": 9,
        "ń": 1, "o": 2, "ó": 3, "p": 4, "r": 5, "s": 6, "ś": 7, "t": 8, "u": 9,
        "w": 1, "y": 2, "z": 3, "ź": 4, "ż": 5
    ]
    
    private let russianAlphabetWeights: [Character: Int] = [
        "а": 1, "б": 2, "в": 3, "г": 4, "д": 5, "е": 6, "ё": 7, "ж": 8, "з": 9,
        "и": 1, "й": 2, "к": 3, "л": 4, "м": 5, "н": 6, "о": 7, "п": 8, "р": 9,
        "с": 1, "т": 2, "у": 3, "ф": 4, "х": 5, "ц": 6, "ч": 7, "ш": 8, "щ": 9,
        "ъ": 1, "ы": 2, "ь": 3, "э": 4, "ю": 5, "я": 6
    ]
    
    private var detectedLanguage: String {
        if name.range(of: "[А-Яа-яЁё]", options: .regularExpression) != nil {
            return "ru"
        } else if name.range(of: "[ąćęłńóśźżĄĆĘŁŃÓŚŹŻ]", options: .regularExpression) != nil {
            return "pl"
        } else {
            return "en"
        }
    }
    
    private var getNameSum: Int {
        let lowercasedName = name.lowercased()
        
        switch detectedLanguage {
        case "pl":
            return calculateNameSum(for: lowercasedName, using: polishAlphabetWeights)
        case "ru":
            return calculateNameSum(for: lowercasedName, using: russianAlphabetWeights)
        default:
            return calculateNameSum(for: lowercasedName, using: englishAlphabetWeights)
        }
    }
    
    init(name: String, dateOfBirthday: Date) {
        self.name = name
        self.dateOfBirthday = dateOfBirthday
        
        let calendar = Calendar.current
        self.day = calendar.component(.day, from: dateOfBirthday)
        self.month = calendar.component(.month, from: dateOfBirthday)
        self.year = calendar.component(.year, from: dateOfBirthday)
    }
    
    // Функция для приведения числа к коду (1-22)
    private func reduceToCode(_ number: Int) -> Int {
        var num = number
        while num > 22 {
            num = String(num).compactMap { $0.wholeNumberValue }.reduce(0, +)
        }
        // Если итог 0, можно например считать его 22 или 1, в зависимости от логики
        return num == 0 ? 22 : num
    }
    
    private func calculateNameSum(for name: String, using weights: [Character: Int]) -> Int {
        return name.lowercased().reduce(0) { sum, char in
            sum + (weights[char] ?? 0)
        }
    }
    
    private var getPersonaCodeValue: Int {
        let sumDateString = "\(day)\(month)\(year)"
        let sumDateInt = Int(sumDateString) ?? 0
        return reduceToCode(sumDateInt)
    }
    
    private var getPathOfDevelopmentValue: Int {
        return reduceToCode(day + month + year)
    }
    
    private var getCommunicationValue: Int {
        return reduceToCode(getPersonaCodeValue + day)
    }
    
    private var getFinancesValue: Int {
        return reduceToCode(getPathOfDevelopmentValue + month)
    }
    
    private var getCareerValue: Int {
        return reduceToCode(getPersonaCodeValue + year)
    }
    
    private var getResourceStateValue: Int {
        return reduceToCode(day + month + year + getPersonaCodeValue)
    }
    
    private var getStrengthsValue: Int {
        return reduceToCode(getNameSum)
    }
    
    private var getRiskZoneValue: Int {
        return reduceToCode(day + getNameSum)
    }
    
    private var getSelfDevelopmentValue: Int {
        return reduceToCode(getPathOfDevelopmentValue + getNameSum)
    }
    
    private var getInnerBalanceValue: Int {
        return reduceToCode(getPersonaCodeValue + getNameSum)
    }
    
    private var getLifeGoalsValue: Int {
        return reduceToCode(getPersonaCodeValue + getPathOfDevelopmentValue + getNameSum)
    }
    
    private var getExperienceAndEvolutionValue: Int {
        return reduceToCode((day + month) + getPersonaCodeValue)
    }
}

