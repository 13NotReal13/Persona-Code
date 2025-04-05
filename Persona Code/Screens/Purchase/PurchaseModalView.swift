//
//  PurchaseModalView.swift
//  Persona Code
//
//  Created by Иван Семикин on 25/02/2025.
//

import SwiftUI
import StoreKit

struct PurchaseModalView: View {
    let personaCode: ShortPersonaCodeData
    
    @EnvironmentObject private var coordinator: NavigationCoordinator
    @StateObject private var viewModel = PreloadPersonaCodeViewModel()
    
    @State private var isLoadingPurchase = false
    @State private var showErrorAlert = false
    @State private var purchaseErrorMessage: String?
    
    var body: some View {
        ZStack {
//            BackgroundImageView()
            
            VStack(spacing: 16) {
                Spacer()
                
                HStack {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("What you will get:")
                            .customText(fontSize: 15)
                            .padding(.leading, 6)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                
                                PurchaseFeatureView(
                                    title: localizedString("Personal analysis"),
                                    description: localizedString("Individual calculation and in-depth analysis of your Persona Code.")
                                )
                            }
                            HStack {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                
                                PurchaseFeatureView(
                                    title: localizedString("12 aspects of personality"),
                                    description: localizedString("Includes key areas: self-realization, career, relationships, finances, strengths, and much more.")
                                )
                            }
                            HStack {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                
                                PurchaseFeatureView(
                                    title: localizedString("Practical recommendations"),
                                    description: localizedString("Tips and strategies for harmonious development, unlocking potential, and achieving goals.")
                                )
                            }
                            HStack {
                                Image(systemName: "square.and.arrow.down.fill")
                                    .foregroundStyle(.green)
                                
                                PurchaseFeatureView(
                                    title: localizedString("Personal PDF report"),
                                    description: localizedString("Download the complete analysis of your Persona Code in a convenient format.")
                                )
                            }
                        }
                        .padding()
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.cyan, lineWidth: 1)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                    
                    DescriptionPurchaseView()
                }
                
                HStack(spacing: 16) {
                    privacyPolicyButton()
                    termsOfUseButton()
                }
                
                ZStack {
                    if let product = IAPManager.shared.getProducts().first {
                        purchaseButton(for: product)
                    } else {
                        Text("Loading price…")
                            .frame(width: UIScreen.main.bounds.width * 0.95)
                            .frame(height: 50)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                    }
                    
                    OutlineGradientView()
                }
                
                cancelButton()
            }
            .blur(radius: isLoadingPurchase ? 3 : 0)
            
            if isLoadingPurchase {
                LoadingPurchaseView()
            }
        }
        .ignoresSafeArea(edges: .top)
        .animation(.easeInOut(duration: 0.3), value: isLoadingPurchase)
        .alert(isPresented: $showErrorAlert) {
            Alert(
                title: Text("Error"),
                message: Text(purchaseErrorMessage ?? localizedString("The purchase could not be completed.")),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    private func purchaseButton(for product: SKProduct) -> some View {
        Button(action: {
            handlePurchase(for: product)
            
            FirebaseLogsManager.shared.logButtonTapped(.confirmPurchase)
        }) {
            Text("Buy for \(product.localizedPrice ?? "N/A")")
                .font(.system(size: 19))
                .bold()
//                .frame(width: UIScreen.main.bounds.width * 0.95)
                .frame(height: 50)
                .foregroundColor(.white)
                .cornerRadius(20)
        }
    }
    
    private func handlePurchase(for product: SKProduct) {
        let calculatedData = PersonaCodeCalculation(
            name: personaCode.name,
            dateOfBirthday: personaCode.dateOfBirthday
        ).personaCodeData
        
        viewModel.savePersonaCode(personaCode: personaCode)
        
        coordinator.dismissModal()
        coordinator.push(.personaCode(calculatedData, isFromPreload: true))
        
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
//                    coordinator.push(.personaCode(calculatedData, isFromPreload: true))
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
                .padding()
                .foregroundColor(.blue)
        }
    }
}


#Preview {
    PurchaseModalView(
        personaCode: ShortPersonaCodeData(
            name: "Иван",
            dateOfBirthday: Date.now,
            dateCreationPersonaCode: Date.now
        )
    )
        .preferredColorScheme(.dark)
}
