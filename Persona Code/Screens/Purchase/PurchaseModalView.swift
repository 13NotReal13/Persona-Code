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
            BackgroundImageView()
            
            VStack(spacing: 16) {
                Spacer()
                
                DescriptionPurchaseView()
                
                VStack(spacing: 16) {
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
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .transition(.opacity)

                VStack(spacing: 16) {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(2)

                    Text("Processing purchase…")
                        .foregroundColor(.white)
                        .font(.headline)
                }
                .transition(.opacity)
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
                .frame(width: UIScreen.main.bounds.width * 0.95)
                .frame(height: 50)
                .foregroundColor(.white)
                .cornerRadius(20)
        }
    }
    
    private func handlePurchase(for product: SKProduct) {
        isLoadingPurchase = true
        
        IAPManager.shared.purchase(
            productID: product.productIdentifier,
            success: {
                isLoadingPurchase = false
                
                DispatchQueue.main.async {
                    let calculatedData = PersonaCodeCalculation(
                        name: personaCode.name,
                        dateOfBirthday: personaCode.dateOfBirthday
                    ).personaCodeData
                    
                    viewModel.savePersonaCode(personaCode: personaCode)
                    
                    FirebaseLogsManager.shared.logPurchaseSuccess(
                        name: personaCode.name,
                        dateBirth: personaCode.dateOfBirthday.formattedDate()
                    )
                    
                    coordinator.dismissModal()
                    coordinator.push(.personaCode(calculatedData, isFromPreload: true))
                }
            },
            failure: { error in
                isLoadingPurchase = false
                
                FirebaseLogsManager.shared.logPurchaseFailure()
                purchaseErrorMessage = error?.localizedDescription
                showErrorAlert = true
            }
        )
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
