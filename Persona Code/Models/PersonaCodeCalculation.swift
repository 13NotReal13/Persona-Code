//
//  PersonaCodeCalculation.swift
//  Persona Code
//
//  Created by Иван Семикин on 23/02/2025.
//

import Foundation

struct PersonaCodeCalculation {
    let name: String
    let dateOfBirthday: Date
    
    var personaCodeData: PersonaCodeModel {
        return PersonaCodeModel(
            name: name,
            dateOfBirthday: dateOfBirthday,
            
            personaCode: PersonaCodeCodes.allCodes[getPersonaCodeValue]!,
            pathOfDevelopment: PathOfDevelopmentCodes.allCodes[getPathOfDevelopmentValue]!,
            communication: CommunicationCodes.allCodes[getCommunicationValue]!,
            finances: FinancesCodes.allCodes[getFinancesValue]!,
            career: CareerCodes.allCodes[getCareerValue]!,
            resourceState: ResourceStateCodes.allCodes[getResourceStateValue]!,
            strengths: StrengthsCodes.allCodes[getStrengthsValue]!,
            riskZone: RiskZoneCodes.allCodes[getRiskZoneValue]!,
            selfDevelopment: SelfDevelopmentCodes.allCodes[getSelfDevelopmentValue]!,
            innerBalance: InnerBalanceCodes.allCodes[getInnerBalanceValue]!,
            lifeGoals: LifeGoalsCodes.allCodes[getLifeGoalsValue]!,
            experienceAndEvolution: ExperienceAndEvolutionCodes.allCodes[getExperienceAndEvolutionValue]!
        )
    }
    
    private let day: Int
    private let month: Int
    private let year: Int
    
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
    
    // Числовое значение имени (примерная логика)
    private var getNameSum: Int {
        // Допустим суммируем юникод значения только букв имени
        // Можно придумать любую логику
        return name.unicodeScalars
            .filter { $0.isASCII == false }
            .map { Int($0.value) }
            .reduce(0, +)
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

