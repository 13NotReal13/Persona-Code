//
//  MatrixScrollView.swift
//  DestinyMatrix
//
//  Created by Иван Семикин on 24/12/2024.
//

import SwiftUI

struct MatrixScrollView: View {
    @StateObject var viewModel: PersonaCodeViewModel
    @State var matrixData: MatrixData
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(showsIndicators: false) {
                VStack(spacing: 30) {
                    ForEach(1..<14) { arkan in
                        SectionView(
                            number: arkan,
                            arkanInfo: matrixData.allArkans[arkan - 1]
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
    let arkanInfo: ArkanInfo
    
    var body: some View {
        VStack {
            ArkanDetailView(arkanInfo: arkanInfo)
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
        AnimatedStarryBackgroundView()
        
        MatrixScrollView(
            viewModel: PersonaCodeViewModel(),
            matrixData: MatrixCalculation(name: "Иван", dateOfBirthday: .now).matrixData
        )
    }
}
