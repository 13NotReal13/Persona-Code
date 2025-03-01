//
//  PersonaCodeListView.swift
//  Persona Code
//
//  Created by Иван Семикин on 24/12/2024.
//

import SwiftUI

struct PersonaCodeListView: View {
    let personaCodeList: [ShortPersonaCodeData]
    var onLongPress: (ShortPersonaCodeData) -> Void
    
    var body: some View {
        ScrollView {
            ForEach(personaCodeList) { personaCode in
                ZStack {
                    VStack(spacing: 8) {
                        HStack {
                            Text("\(personaCode.name)")
                                .onLongPressGesture {
                                    onLongPress(personaCode)
                                }
                            Text(" - \(personaCode.dateOfBirthday.formattedDate())")
                        }
                        .customText(fontSize: 17)
                        
                        Text("Дата создания: \(personaCode.dateCreationPersonaCode.formattedDate())")
                            .customText(fontSize: 11)
                    }
                    .frame(maxWidth: .infinity)
//                    .customButtonStyle(shape: .capsule)
                    
                    HStack {
                        Spacer()
                        
                        NavigationLink(
                            destination: PersonaCodeView(
                                personaCodeData: PersonaCodeCalculation(
                                    name: personaCode.name,
                                    dateOfBirthday: personaCode.dateOfBirthday
                                ).personaCodeData,
                                isFromPreload: false
                            )
                        ) {
                                Image(systemName: "chevron.right")
                                    .customText(fontSize: 17)
                                    .padding()
                            }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 16)
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    // Создаём тестовые данные
    let date1 = Calendar.current.date(from: DateComponents(year: 1994, month: 1, day: 19))!
    let date2 = Calendar.current.date(from: DateComponents(year: 1998, month: 5, day: 25))!
    
    let testPersonaCodeList = [
        ShortPersonaCodeData(
            name: "Иван",
            dateOfBirthday: date1,
            dateCreationPersonaCode: Date()
        ),
        ShortPersonaCodeData(
            name: "Анна",
            dateOfBirthday: date2,
            dateCreationPersonaCode: Date()
        )
    ]
    
    return PersonaCodeListView(
        personaCodeList: testPersonaCodeList,
        onLongPress: { _ in
        }
    )
    .background(.black)
}

