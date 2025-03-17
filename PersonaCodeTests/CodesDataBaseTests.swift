//
//  CodesDataBaseTests.swift
//  PersonaCodeTests
//
//  Created by Иван Семикин on 17/03/2025.
//

import XCTest
@testable import Persona_Code

final class CodesDataBaseTests: XCTestCase {
    let expectedCodeRange: Set<Int> = Set(1...22)
    
    // Test CareerCodes
    func testCareerCodes_EN() {
        validateCodes(CareerCodes_EN.allCodes, locale: "EN")
    }
    func testCareerCodes_PL() {
        validateCodes(CareerCodes_PL.allCodes, locale: "PL")
    }
    func testCareeCodes_RU() {
        validateCodes(CareerCodes_RU.allCodes, locale: "RU")
    }
    
    // Test CommunicationCodes
    func testCommunicationCodes_EN() {
        validateCodes(CommunicationCodes_EN.allCodes, locale: "EN")
    }
    func testCommunicationCodes_PL() {
        validateCodes(CommunicationCodes_PL.allCodes, locale: "PL")
    }
    func testCommunicationCodes_RU() {
        validateCodes(CommunicationCodes_RU.allCodes, locale: "RU")
    }
    
    // Test ExperienceAndEvolutionCodes
    func testExperienceAndEvolutionCodes_EN() {
        validateCodes(ExperienceAndEvolutionCodes_EN.allCodes, locale: "EN")
    }
    func testExperienceAndEvolutionCodes_PL() {
        validateCodes(ExperienceAndEvolutionCodes_PL.allCodes, locale: "PL")
    }
    func testExperienceAndEvolutionCodes_RU() {
        validateCodes(ExperienceAndEvolutionCodes_RU.allCodes, locale: "RU")
    }
    
    // Test FinancesCodes
    func testFinancesCodes_EN() {
        validateCodes(FinancesCodes_EN.allCodes, locale: "EN")
    }
    func testFinancesCodes_PL() {
        validateCodes(FinancesCodes_PL.allCodes, locale: "PL")
    }
    func testFinancesCodes_RU() {
        validateCodes(FinancesCodes_RU.allCodes, locale: "RU")
    }

    // Test InnerBalanceCodes
    func testInnerBalanceCodes_EN() {
        validateCodes(InnerBalanceCodes_EN.allCodes, locale: "EN")
    }
    func testInnerBalanceCodes_PL() {
        validateCodes(InnerBalanceCodes_PL.allCodes, locale: "PL")
    }
    func testInnerBalanceCodes_RU() {
        validateCodes(InnerBalanceCodes_RU.allCodes, locale: "RU")
    }

    // Test LifeGoalsCodes
    func testLifeGoalsCodes_EN() {
        validateCodes(LifeGoalsCodes_EN.allCodes, locale: "EN")
    }
    func testLifeGoalsCodes_PL() {
        validateCodes(LifeGoalsCodes_PL.allCodes, locale: "PL")
    }
    func testLifeGoalsCodes_RU() {
        validateCodes(LifeGoalsCodes_RU.allCodes, locale: "RU")
    }

    // Test PathOfDevelopmentCodes
    func testPathOfDevelopmentCodes_EN() {
        validateCodes(PathOfDevelopmentCodes_EN.allCodes, locale: "EN")
    }
    func testPathOfDevelopmentCodes_PL() {
        validateCodes(PathOfDevelopmentCodes_PL.allCodes, locale: "PL")
    }
    func testPathOfDevelopmentCodes_RU() {
        validateCodes(PathOfDevelopmentCodes_RU.allCodes, locale: "RU")
    }

    // Test PersonaCodeCodes
    func testPersonaCodeCodes_EN() {
        validateCodes(PersonaCodeCodes_EN.allCodes, locale: "EN")
    }
    func testPersonaCodeCodes_PL() {
        validateCodes(PersonaCodeCodes_PL.allCodes, locale: "PL")
    }
    func testPersonaCodeCodes_RU() {
        validateCodes(PersonaCodeCodes_RU.allCodes, locale: "RU")
    }

    // Test ResourceStateCodes
    func testResourceStateCodes_EN() {
        validateCodes(ResourceStateCodes_EN.allCodes, locale: "EN")
    }
    func testResourceStateCodes_PL() {
        validateCodes(ResourceStateCodes_PL.allCodes, locale: "PL")
    }
    func testResourceStateCodes_RU() {
        validateCodes(ResourceStateCodes_RU.allCodes, locale: "RU")
    }

    // Test RiskZoneCodes
    func testRiskZoneCodes_EN() {
        validateCodes(RiskZoneCodes_EN.allCodes, locale: "EN")
    }
    func testRiskZoneCodes_PL() {
        validateCodes(RiskZoneCodes_PL.allCodes, locale: "PL")
    }
    func testRiskZoneCodes_RU() {
        validateCodes(RiskZoneCodes_RU.allCodes, locale: "RU")
    }

    // Test SelfDevelopmentCodes
    func testSelfDevelopmentCodes_EN() {
        validateCodes(SelfDevelopmentCodes_EN.allCodes, locale: "EN")
    }
    func testSelfDevelopmentCodes_PL() {
        validateCodes(SelfDevelopmentCodes_PL.allCodes, locale: "PL")
    }
    func testSelfDevelopmentCodes_RU() {
        validateCodes(SelfDevelopmentCodes_RU.allCodes, locale: "RU")
    }

    // Test StrengthsCodes
    func testStrengthsCodes_EN() {
        validateCodes(StrengthsCodes_EN.allCodes, locale: "EN")
    }
    func testStrengthsCodes_PL() {
        validateCodes(StrengthsCodes_PL.allCodes, locale: "PL")
    }
    func testStrengthsCodes_RU() {
        validateCodes(StrengthsCodes_RU.allCodes, locale: "RU")
    }
    
    private func validateCodes(_ codes: [Int: CodeInfo], locale: String) {
        XCTAssertEqual(codes.count, 22, "Должно быть 22 кода")
        XCTAssertEqual(Set(codes.keys), expectedCodeRange, "Коды должны быть от 1 до 22")
        
        for (_, code) in codes {
            switch locale {
            case "EN":
                XCTAssertTrue(code.title.range(of: "[A-Za-z]", options: .regularExpression) != nil, "Заголовок должен быть на английском")
            case "PL":
                XCTAssertTrue(code.title.range(of: "[A-Za-zĄĆĘŁŃÓŚŹŻąćęłńóśźż]", options: .regularExpression) != nil, "Заголовок должен быть на польском")
            case "RU":
                XCTAssertTrue(code.title.range(of: "[А-Яа-яЁё]", options: .regularExpression) != nil, "Заголовок должен быть на русском")
            default:
                XCTFail("Неизвестная локаль")
            }
        }
    }
}
