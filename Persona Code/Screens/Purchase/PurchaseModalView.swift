//
//  PurchaseModalView.swift
//  Persona Code
//
//  Created by Иван Семикин on 25/02/2025.
//

import SwiftUI
import StoreKit

enum PlanType {
    case demo
    case full
}

struct PurchaseModalView: View {
    var shortPersonaCode: ShortPersonaCodeData
    let isFromPreloadScreen: Bool
    
    @EnvironmentObject private var coordinator: NavigationCoordinator
    @StateObject private var viewModel = PreloadPersonaCodeViewModel()
    
    @State private var selectedPlan: PlanType = .demo
    
    @State private var isLoadingPurchase = false
    @State private var showErrorAlert = false
    @State private var purchaseErrorMessage: String?
    
    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                DemoPLanView(selectedPlan: $selectedPlan)
                    .opacity(isFromPreloadScreen ? 1 : 0.5)
                    .onTapGesture {
                        withAnimation(.interactiveSpring()) {
                            selectedPlan = .demo
                        }
                    }
                    .disabled(!isFromPreloadScreen)
                
                FullPlanView(selectedPlan: $selectedPlan)
                    .onTapGesture {
                        withAnimation(.interactiveSpring()) {
                            selectedPlan = .full
                        }
                    }
                
                Spacer()
                                
                HStack(spacing: 16) {
                    privacyPolicyButton()
                    termsOfUseButton()
                }
                
                switch selectedPlan {
                case .demo:
                    openDemoPersonaCodeButton()
                case .full:
                    if let product = IAPManager.shared.getProducts().first {
                        purchaseButton(for: product)
                    } else {
                        Text("Loading price…")
                            .customText(fontSize: 19, customFont: .interDisplaySemiBold)
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .background(OutlineGradientButtonBackgroundView())
                            .padding(.horizontal)
                    }
                }
                
                cancelButton()
            }
            .padding(.vertical)
            .blur(radius: isLoadingPurchase ? 3 : 0)
            
            if isLoadingPurchase {
                LoadingPurchaseView()
            }
        }
        .onAppear {
            selectedPlan = isFromPreloadScreen ? .demo : .full
        }
        .animation(.easeInOut(duration: 0.3), value: isLoadingPurchase)
        .background(BackgroundView(shadowLevel: .high))
        .alert(isPresented: $showErrorAlert) {
            Alert(
                title: Text("Error"),
                message: Text(purchaseErrorMessage ?? localizedString("The purchase could not be completed.")),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    private func openDemoPersonaCodeButton() -> some View {
        Button {
            var updatedCode = shortPersonaCode
            updatedCode.isFullVersion = false
            
            if isFromPreloadScreen {
                StorageManager.shared.add(shortPersonaCodeData: updatedCode)
            }
            
            coordinator.dismissModal()
            coordinator.push(.personaCode(updatedCode, isFromPreload: true))
            
            FirebaseLogsManager.shared.logDemoPersonaCodeCreated(
                name: updatedCode.name,
                dateBirth: updatedCode.dateOfBirthday.formattedDate()
            )
        } label: {
            Text("Unlock for Free")
                .customText(fontSize: 19, customFont: .interDisplaySemiBold)
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(style: StrokeStyle(lineWidth: 2))
                        .foregroundStyle(.gray.opacity(0.6))
                )
                .padding(.horizontal)
        }
    }
    
    private func purchaseButton(for product: SKProduct) -> some View {
        Button {
            handlePurchase(for: product)
            
            FirebaseLogsManager.shared.logButtonTapped(.confirmPurchase)
        } label: {
            Text("Unlock for \(product.localizedPrice ?? "N/A")")
                .customText(fontSize: 19, customFont: .interDisplaySemiBold)
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .background(OutlineGradientButtonBackgroundView())
                .padding(.horizontal)
        }
    }
    
    private func handlePurchase(for product: SKProduct) {
        var updatedCode = shortPersonaCode
        
        if isFromPreloadScreen {
            StorageManager.shared.add(shortPersonaCodeData: shortPersonaCode)
        } else {
            updatedCode.isFullVersion = true
            StorageManager.shared.updateToFullVersion(shortPersonaCodeData: updatedCode)
        }
        
        coordinator.dismissModal()
        coordinator.push(
            .personaCode(
                isFromPreloadScreen ? shortPersonaCode : updatedCode,
                isFromPreload: true
            )
        )
//
//        isLoadingPurchase = true
//        
//        IAPManager.shared.purchase(
//            productID: product.productIdentifier,
//            success: {
//                isLoadingPurchase = false
//                
//                DispatchQueue.main.async {
//                    let calculatedData = PersonaCodeCalculation(
//                        name: personaCode.name,
//                        dateOfBirthday: personaCode.dateOfBirthday
//                    ).personaCodeData
//                    
//                    viewModel.savePersonaCode(personaCode: personaCode)
//                    
//                    FirebaseLogsManager.shared.logPurchaseSuccess(
//                        name: personaCode.name,
//                        dateBirth: personaCode.dateOfBirthday.formattedDate()
//                    )
//                    
//                    coordinator.dismissModal()
//                    coordinator.push(
//                        .personaCode(
//                            calculatedData,
//                            isFromPreload: true,
//                            isFullVersion: true
//                        )
//                    )
//                }
//            },
//            failure: { error in
//                isLoadingPurchase = false
//                
//                FirebaseLogsManager.shared.logPurchaseFailure()
//                purchaseErrorMessage = error?.localizedDescription
//                showErrorAlert = true
//            }
//        )
    }
    
    private func termsOfUseButton() -> some View {
        Button(action: {
            if let url = URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/") {
                UIApplication.shared.open(url)
            }
            
            FirebaseLogsManager.shared.logButtonTapped(.termsOfUse)
        }) {
            Text("Terms of Use")
                .font(.footnote)
                .foregroundColor(.gray)
        }
    }
    
    private func privacyPolicyButton() -> some View {
        Button(action: {
            if let url = URL(string: "https://13notreal13.github.io/privacy-policy-persona-code/privacy.html") {
                UIApplication.shared.open(url)
            }
            
            FirebaseLogsManager.shared.logButtonTapped(.privacyPolicy)
        }) {
            Text("Privacy Policy")
                .font(.footnote)
                .foregroundColor(.gray)
        }
    }
    
    private func cancelButton() -> some View {
        Button(action: {
            FirebaseLogsManager.shared.logButtonTapped(.cancelPurchase)
            
            coordinator.dismissModal()
        }) {
            Text("Cancel")
                .frame(maxWidth: .infinity)
                .foregroundColor(.red)
        }
    }
}


#Preview {
    PurchaseModalView(
        shortPersonaCode: ShortPersonaCodeData(
            name: "Иван",
            dateOfBirthday: Date.now,
            dateCreationPersonaCode: Date.now
        ),
        isFromPreloadScreen: false
    )
        .preferredColorScheme(.dark)
}
