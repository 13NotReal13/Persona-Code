//
//  PreloadPersonaCodeView.swift
//  Persona Code
//
//  Created by Иван Семикин on 23/02/2025.
//

import SwiftUI

struct PreloadPersonaCodeView: View {
    @Environment(\.dismiss) var dismiss
    
    let personaCode: ShortPersonaCodeData
    
    @StateObject private var viewModel = PreloadPersonaCodeViewModel()
    @State private var navigateToMatrix = false
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                
                VStack {
                    Spacer()
                    
                    if viewModel.showPurchaseModal {
                        Button {
                            viewModel.showPurchaseModal = true
                        } label: {
                            Text("Открыть")
                                .customText(fontSize: 17)
                                .customButtonStyle(width: UIScreen.main.bounds.width * 0.6, shape: .capsule)
                        }
                    } else {
//                        LoadProgressView(viewModel: viewModel)
                    }
                    
                    Spacer()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    if viewModel.loadWasFinished {
                        NavigationBackButtonView { dismiss() }
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    CustomNavigationTitleView(title: "Код Личности")
                }
            }
            .onAppear {
                viewModel.startLoading()
            }
//            .background(
//                NavigationLink(
//                    destination: MatrixView(
//                        matrixData: MatrixCalculation(
//                            name: matrix.name,
//                            dateOfBirthday: matrix.dateOfBirthday
//                        ).matrixData,
//                        isFromPreload: true
//                    )
//                    .environmentObject(navigationManager),
//                    isActive: $navigateToMatrix
//                ) {
//                    EmptyView()
//                }
//            )
//            .sheet(isPresented: $viewModel.showPurchaseModal) {
//                PurchaseModalView(
//                    isPresented: $viewModel.showPurchaseModal,
//                    navigateToMatrix: $navigateToMatrix
//                )
//            }
        }
        .navigationBarHidden(true)
        .onChange(of: navigateToMatrix) { isNavigating in
            if isNavigating {
                saveMatrix()
            }
        }
    }
    
    private func saveMatrix() {
        StorageManager().add(shortPersonaCodeData: personaCode)
    }
}

#Preview {
    ZStack {
        BackgroundView()
        
        PreloadPersonaCodeView(
            personaCode: ShortPersonaCodeData(
                name: "Иван",
                dateOfBirthday: .now,
                dateCreationPersonaCode: .now
            )
        )
    }
}
