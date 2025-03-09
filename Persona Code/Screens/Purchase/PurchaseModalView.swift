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
    
    var body: some View {
        ZStack {
            BackgroundImageView()
            
            VStack(spacing: 16) {
                Spacer()
                
                DescriptionPurchaseView()
                
                VStack(spacing: 8) {
                    HStack(spacing: 16) {
                        restorePurchasesButton()
                        termsOfUseButton()
                    }
                    privacyPolicyButton()
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
        }
        .ignoresSafeArea(edges: .top)
    }
    
    private func purchaseButton(for product: SKProduct) -> some View {
        Button(action: {
            handlePurchase(for: product)
        }) {
            Text("Buy for \(product.localizedPrice ?? "N/A")")
                .frame(width: UIScreen.main.bounds.width * 0.95)
                .frame(height: 50)
                .foregroundColor(.white)
                .cornerRadius(20)
        }
    }
    
    private func handlePurchase(for product: SKProduct) {
        IAPManager.shared.purchase(
            productID: product.productIdentifier,
            success: {
                DispatchQueue.main.async {
                    let calculatedData = PersonaCodeCalculation(
                        name: personaCode.name,
                        dateOfBirthday: personaCode.dateOfBirthday
                    ).personaCodeData
                    
                    viewModel.savePersonaCode(personaCode: personaCode)
                    
                    coordinator.dismissModal()
                    coordinator.push(.personaCode(calculatedData, isFromPreload: true))
                }
            },
            failure: { error in
                showErrorAlert(error: error)
            }
        )
    }
    
    private func restorePurchasesButton() -> some View {
        Button {
            IAPManager.shared.restorePurchases()
        } label: {
            Text("Restore purchases")
                .font(.footnote)
                .foregroundColor(.gray)
        }
    }
    
    private func termsOfUseButton() -> some View {
        Button(action: {
            if let url = URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/") {
                UIApplication.shared.open(url)
            }
        }) {
            Text("Terms of Use")
                .font(.footnote)
                .foregroundColor(.gray)
        }
    }
    
    private func privacyPolicyButton() -> some View {
        Button(action: {
            if let url = URL(string: "https://13notreal13.github.io/privacy-policy-destiny-matrix/privacy.html") {
                UIApplication.shared.open(url)
            }
        }) {
            Text("Privacy Policy")
                .font(.footnote)
                .foregroundColor(.gray)
        }
    }
    
    private func cancelButton() -> some View {
        Button(action: {
            coordinator.dismissModal()
        }) {
            Text("Cancel")
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.blue)
        }
    }
    
    private func showErrorAlert(error: Error?) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootVC = windowScene.windows.first?.rootViewController else { return }
        
        let alert = UIAlertController(
            title: "Ошибка",
            message: error?.localizedDescription ?? "Не удалось завершить покупку.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Ок", style: .default))
        rootVC.present(alert, animated: true)
    }
}


//#Preview {
//    PurchaseModalView(isPresented: .constant(true), personaCode: .constant(false))
////        .preferredColorScheme(.dark)
//}
