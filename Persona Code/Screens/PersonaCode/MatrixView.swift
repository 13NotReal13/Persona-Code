//
//  MatrixView.swift
//  DestinyMatrix
//
//  Created by Иван Семикин on 11/11/2024.
//

import SwiftUI

struct MatrixView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    
    @Environment(\.presentationMode) private var presentationMode
    
    @State var matrixData: MatrixData
    var isFromPreload: Bool
    
    @StateObject private var viewModel = PersonaCodeViewModel()
    @ObservedObject private var storageManager = StorageManager()
    
    var body: some View {
        ZStack {
            NavigationView {
                ZStack(alignment: .leading) {
                    AnimatedStarryBackgroundView()
                    ShadowBackgroundView()
                    
                    VStack {
                        PersonalTitleView(matrixData: matrixData)
                        
                        MatrixScrollView(
                            viewModel: viewModel,
                            matrixData: matrixData
                        )
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            if isFromPreload {
                                // Сбрасываем навигацию к корню (HomeView)
                                navigationManager.isRootActive = false
                            } else {
                                // Возвращаемся на предыдущий экран
                                presentationMode.wrappedValue.dismiss()
                            }
                        } label: {
                            Image(systemName: isFromPreload ? "house" : "chevron.left")
                                .customText(fontSize: 17, textColor: .white)
                        }
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        DownloadPDFButtonView(viewModel: viewModel, matrixData: matrixData)
                    }
                }
                .onAppear {
                    FirebaseLogManager.shared.logScreenView(screenName: "matrix")
                    
                    if !ReviewRequestManager.shared.reviewPromptWasShowing() {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            checkReviewConditions()
                        }
                    }
                }
            }
            .navigationBarHidden(true)
            
            LeftMenuView(viewModel: viewModel)
        }
        .sheet(isPresented: $viewModel.showShareSheet) {
            ShareSheet(items: viewModel.shareItems)
        }
    }
    
    private func checkReviewConditions() {
        let matricesCount = storageManager.historyMatrixData.count
        
        ReviewRequestManager.shared.checkReviewConditions(matricesCount: matricesCount)
    }
}

#Preview {
    let dateComponents = DateComponents(year: 1994, month: 1, day: 19)
    let calendar = Calendar.current
    let date = calendar.date(from: dateComponents)!
    
    let matrixData = MatrixCalculation(
        name: "Иван",
        dateOfBirthday: date
    )
    
    MatrixView(matrixData: matrixData.matrixData, isFromPreload: true)
}
