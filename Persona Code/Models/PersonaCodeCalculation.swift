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
            
            destinyNumber: PersonaCodeCodes.allCodes[destinyNumberValue]!,
            lifePath: LifePathEnergies.allCodes[lifePathValue]!,
            relationships: RelationshipsEnergies.allCodes[relationshipsValue]!,
            finances: FinancesCodes.allCodes[financesValue]!,
            career: CareerCodes.allCodes[careerValue]!,
            health: ResourceStateCodes.allCodes[healthValue]!,
            talents: TalentsEnergies.allCodes[talentsValue]!,
            challenges: RiskZoneCodes.allCodes[challengesValue]!,
            personalGrowth: PersonalGrowthEnergies.allCodes[personalGrowthValue]!,
            innerSelf: InnerSelfEnergies.allCodes[innerSelfValue]!,
            purpose: PurposeEnergies.allCodes[purposeValue]!,
            karmicLessons: KarmicLessonsEnergies.allCodes[karmicLessonsValue]!
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
    private var nameSum: Int {
        // Допустим суммируем юникод значения только букв имени
        // Можно придумать любую логику
        return name.unicodeScalars
            .filter { $0.isASCII == false }
            .map { Int($0.value) }
            .reduce(0, +)
    }
    
    // Число Судьбы
    private var destinyNumberValue: Int {
        let sumDateString = "\(day)\(month)\(year)"
        let sumDateInt = Int(sumDateString) ?? 0
        return reduceToCode(sumDateInt)
    }
    
    // Жизненный Путь
    private var lifePathValue: Int {
        return reduceToCode(day + month + year)
    }
    
    // Остальные берём из описанных формул выше:
    private var relationshipsValue: Int {
        return reduceToCode(destinyNumberValue + day)
    }
    
    private var financesValue: Int {
        return reduceToCode(lifePathValue + month)
    }
    
    private var careerValue: Int {
        return reduceToCode(destinyNumberValue + year)
    }
    
    private var healthValue: Int {
        return reduceToCode(day + month + year + destinyNumberValue)
    }
    
    private var talentsValue: Int {
        return reduceToCode(nameSum)
    }
    
    private var challengesValue: Int {
        return reduceToCode(day + nameSum)
    }
    
    private var personalGrowthValue: Int {
        return reduceToCode(lifePathValue + nameSum)
    }
    
    private var innerSelfValue: Int {
        return reduceToCode(destinyNumberValue + nameSum)
    }
    
    private var purposeValue: Int {
        return reduceToCode(destinyNumberValue + lifePathValue + nameSum)
    }
    
    private var karmicLessonsValue: Int {
        return reduceToCode((day + month) + destinyNumberValue)
    }
}

