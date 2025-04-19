//
//  HistoryCardView.swift
//  Persona Code
//
//  Created by Иван Семикин on 24/12/2024.
//

import SwiftUI

struct HistoryCardView: View {
    @EnvironmentObject private var coordinator: NavigationCoordinator
    
    let shortPersonaCode: ShortPersonaCodeData
    var onLongPress: () -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white.opacity(0.1))
                .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 3)
            
            VStack {
                if shortPersonaCode.isFull {
                    FullVersionIconView(fontSize: 15)
                } else {
                    DemoVersionIconView(fontSize: 15)
                }
                
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text("\(shortPersonaCode.name) - \(shortPersonaCode.dateOfBirthday.formattedDate())")
                                .font(.headline)
                                .foregroundColor(.white)
                                .onLongPressGesture(perform: onLongPress)
                        }
                        
                        Text("Created: \(shortPersonaCode.dateCreationPersonaCode.formattedDate())")
                            .font(.footnote)
                            .foregroundColor(.white.opacity(0.7))
                    }
                    Spacer()
                    
                    Button {
                        coordinator.push(.personaCode(shortPersonaCode, isFromPreload: false))
                    } label: {
                        Image(systemName: "chevron.right")
                            .foregroundColor(.white)
                            .padding()
                    }
                }
                
                if !shortPersonaCode.isFull {
                    Button {
                        coordinator.present(
                            .purchase(
                                personaCode: shortPersonaCode,
                                isFromPreloadScreen: false
                            )
                        )
                    } label: {
                        Text("Unlock Full Version")
                            .customText(fontSize: 15, customFont: .interDisplaySemiBold)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 12)
                            .background(OutlineGradientButtonBackgroundView())
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
            BackgroundView(shadowLevel: .high)
            
            VStack {
                HistoryCardView(
                    shortPersonaCode: testPersonaCodeData,
                    onLongPress: { }
                )
                .padding()
                
                Spacer()
            }
        }
        .environmentObject(NavigationCoordinator.shared)
    }
}
#endif
