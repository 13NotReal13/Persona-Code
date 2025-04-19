//
//  PersonaCodeScrollView.swift
//  Persona Code
//
//  Created by Иван Семикин on 24/02/2025.
//

import SwiftUI

struct PersonaCodeScrollView: View {
    @StateObject var viewModel: PersonaCodeViewModel
    @State var personaCodeData: PersonaCodeModel
    
    let shortPersonCodeData: ShortPersonaCodeData
    
    @EnvironmentObject private var navigationCoordinator: NavigationCoordinator
    
    let isFullVersion: Bool
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(showsIndicators: false) {
                VStack(spacing: 30) {
                    let categories = isFullVersion ? 1..<13 : 1..<4
                    
                    ForEach(categories, id: \.self) { code in
                        SectionView(
                            number: code,
                            codeInfo: personaCodeData.allCodes[code - 1]
                        )
                    }
                    
                    if !isFullVersion {
                        VStack {
                            if let product = IAPManager.shared.getProducts().first {
                                Button {
                                    navigationCoordinator.present(
                                        .purchase(
                                            personaCode: shortPersonCodeData, isFromPreloadScreen: false)
                                    )
                                } label: {
                                    Text("Unlock All For \(product.localizedPrice ?? "N/A")")
                                        .customText(fontSize: 17, customFont: .interDisplaySemiBold)
                                        .padding(12)
                                        .frame(maxWidth: .infinity)
                                        .background(OutlineGradientButtonBackgroundView())
                                        .padding(4)
                                }
                            } else {
                                Text("Loading price…")
                                    .customText(fontSize: 17, customFont: .interDisplaySemiBold)
                                    .padding(12)
                                    .frame(maxWidth: .infinity)
                                    .background(OutlineGradientButtonBackgroundView())
                                    .padding(4)
                            }
                            
                            Text("Available instantly. No subscription. One-time purchase.")
                                .font(.custom(CustomFont.interVariable.rawValue, size: 13))
                                .foregroundStyle(.gray)
                                .multilineTextAlignment(.center)
                        }
                    } else {
                        
                    }
                }
            }
            .padding()
            .padding(.leading, 32)
            .onPreferenceChange(SectionPositionPreferenceKey.self) { positions in
                let screenMidY = UIScreen.main.bounds.midY
                if let closestSection = positions.min(by: { abs($0.value - screenMidY) < abs($1.value - screenMidY) })?.key {
                    if viewModel.selectedSectionForLeftButtons != closestSection {
                        viewModel.selectedSectionForLeftButtons = closestSection
                    }
                }
            }
            .onReceive(viewModel.scrollToSection) { section in
                withAnimation {
                    proxy.scrollTo(section, anchor: .top)
                    viewModel.selectedSection = section
                }
            }
        }
    }
}

struct SectionView: View {
    let number: Int
    let codeInfo: CodeInfo
    
    var body: some View {
        VStack {
            CodeDetailView(codeInfo: codeInfo)
        }
        .id(number)
        .background(
            GeometryReader { geometry in
                Color.clear
                    .preference(
                        key: SectionPositionPreferenceKey.self,
                        value: [number: geometry.frame(in: .global).midY]
                    )
            }
        )
    }
}

struct SectionPositionPreferenceKey: PreferenceKey {
    static var defaultValue: [Int: CGFloat] = [:]
    
    static func reduce(value: inout [Int: CGFloat], nextValue: () -> [Int: CGFloat]) {
        value.merge(nextValue()) { $1 }
    }
}

#Preview {
    ZStack {
        BackgroundView(shadowLevel: .high)
        
        PersonaCodeScrollView(
            viewModel: PersonaCodeViewModel(),
            personaCodeData: PersonaCodeCalculation(
                name: "Иван",
                dateOfBirthday: .now
            ).personaCodeData,
            shortPersonCodeData: ShortPersonaCodeData(
                name: "Ivan",
                dateOfBirthday: Date.now,
                dateCreationPersonaCode: Date.now
            ),
            isFullVersion: false
        )
    }
}
