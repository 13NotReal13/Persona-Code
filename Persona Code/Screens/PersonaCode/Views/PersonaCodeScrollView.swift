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
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(showsIndicators: false) {
                VStack(spacing: 30) {
                    ForEach(1..<14) { energy in
                        SectionView(
                            number: energy,
                            energyInfo: personaCodeData.allEnergies[energy - 1]
                        )
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
            .onChange(of: viewModel.selectedSection) { section in
                withAnimation {
                    proxy.scrollTo(section, anchor: .top)
                }
            }
        }
    }
}

struct SectionView: View {
    let number: Int
    let energyInfo: EnergyInfo
    
    var body: some View {
        VStack {
            EnergyDetailView(energyInfo: energyInfo)
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
        BackgroundView()
        
        PersonaCodeScrollView(
            viewModel: PersonaCodeViewModel(),
            personaCodeData: PersonaCodeCalculation(name: "Иван", dateOfBirthday: .now).personaCodeData
        )
    }
}
