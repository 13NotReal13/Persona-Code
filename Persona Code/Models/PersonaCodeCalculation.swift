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
            
            destinyNumber: DestinyNumberEnergies.allEnergies[destinyNumberValue]!,
            lifePath: LifePathEnergies.allEnergies[lifePathValue]!,
            relationships: RelationshipsEnergies.allEnergies[relationshipsValue]!,
            finances: FinancesEnergies.allEnergies[financesValue]!,
            career: CareerEnergies.allEnergies[careerValue]!,
            health: HealthEnergies.allEnergies[healthValue]!,
            talents: TalentsEnergies.allEnergies[talentsValue]!,
            challenges: ChallengesEnergies.allEnergies[challengesValue]!,
            personalGrowth: PersonalGrowthEnergies.allEnergies[personalGrowthValue]!,
            innerSelf: InnerSelfEnergies.allEnergies[innerSelfValue]!,
            purpose: PurposeEnergies.allEnergies[purposeValue]!,
            karmicLessons: KarmicLessonsEnergies.allEnergies[karmicLessonsValue]!
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
    
    // Функция для приведения числа к энергии (1-22)
    private func reduceToEnergy(_ number: Int) -> Int {
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
        return reduceToEnergy(sumDateInt)
    }
    
    // Жизненный Путь
    private var lifePathValue: Int {
        return reduceToEnergy(day + month + year)
    }
    
    // Остальные берём из описанных формул выше:
    private var relationshipsValue: Int {
        return reduceToEnergy(destinyNumberValue + day)
    }
    
    private var financesValue: Int {
        return reduceToEnergy(lifePathValue + month)
    }
    
    private var careerValue: Int {
        return reduceToEnergy(destinyNumberValue + year)
    }
    
    private var healthValue: Int {
        return reduceToEnergy(day + month + year + destinyNumberValue)
    }
    
    private var talentsValue: Int {
        return reduceToEnergy(nameSum)
    }
    
    private var challengesValue: Int {
        return reduceToEnergy(day + nameSum)
    }
    
    private var personalGrowthValue: Int {
        return reduceToEnergy(lifePathValue + nameSum)
    }
    
    private var innerSelfValue: Int {
        return reduceToEnergy(destinyNumberValue + nameSum)
    }
    
    private var purposeValue: Int {
        return reduceToEnergy(destinyNumberValue + lifePathValue + nameSum)
    }
    
    private var karmicLessonsValue: Int {
        return reduceToEnergy((day + month) + destinyNumberValue)
    }
}

