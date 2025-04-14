//
//  HistoryCardView.swift
//  Persona Code
//
//  Created by Иван Семикин on 24/12/2024.
//

import SwiftUI

struct HistoryCardView: View {
    @EnvironmentObject private var coordinator: NavigationCoordinator
    
    let personaCode: ShortPersonaCodeData
    var onLongPress: () -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white.opacity(0.1))
                .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 3)
            
            VStack {
                if personaCode.isFull {
                    FullVersionIconView(fontSize: 15)
                } else {
                    DemoVersionIconView(fontSize: 15)
                }
                
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        
                        HStack {
                            Text("\(personaCode.name) - \(personaCode.dateOfBirthday.formattedDate())")
                                .font(.headline)
                                .foregroundColor(.white)
                                .onLongPressGesture(perform: onLongPress)
                        }
                        
                        
                        Text("Created: \(personaCode.dateCreationPersonaCode.formattedDate())")
                            .font(.footnote)
                            .foregroundColor(.white.opacity(0.7))
                    }
                    Spacer()
                    
                    Button {
                        let calculatedData = PersonaCodeCalculation(
                            name: personaCode.name,
                            dateOfBirthday: personaCode.dateOfBirthday
                        ).personaCodeData
                        coordinator.push(
                            .personaCode(
                                calculatedData,
                                isFromPreload: false,
                                isFullVersion: personaCode.isFull ? true : false
                            )
                        )
                    } label: {
                        Image(systemName: "chevron.right")
                            .foregroundColor(.white)
                            .padding()
                    }
                }
            }
            .padding()
        }
        .background(Color.clear)
    }
}

// Превью для HistoryCardView
#if DEBUG
struct HistoryCardView_Previews: PreviewProvider {
    static var previews: some View {
        // Создаём тестовые данные
        let date1 = Calendar.current.date(from: DateComponents(year: 1994, month: 1, day: 19))!
        
        let testPersonaCodeData = ShortPersonaCodeData(
            name: "Иван",
            dateOfBirthday: date1,
            dateCreationPersonaCode: Date()
        )
        
        ZStack {
            Color.black.ignoresSafeArea()
            HistoryCardView(
                personaCode: testPersonaCodeData,
                onLongPress: { }
            )
            .padding()
        }
        .environmentObject(NavigationCoordinator.shared)
    }
}
#endif
