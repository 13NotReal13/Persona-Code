//
//  PurchaseModalView.swift
//  Persona Code
//
//  Created by Иван Семикин on 25/02/2025.
//

import SwiftUI

struct PurchaseModalView: View {
    @Binding var isPresented: Bool
    @Binding var navigateToPersonaCode: Bool
    
    var body: some View {
        ZStack {
            BackgroundImageView()
            
            VStack(spacing: 16) {
                Spacer()
                
                DescriptionPurchaseView()
                
                VStack(spacing: 8) {
                    HStack(spacing: 16) {
                        Button {
                            IAPManager.shared.restorePurchases()
                        } label: {
                            Text("Восстановить покупки")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                        
                        Button(action: {
                            if let url = URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/") {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            Text("Условия использования")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                    }
                    
                    Button(action: {
                        if let url = URL(string: "https://13notreal13.github.io/privacy-policy-destiny-matrix/privacy.html") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        Text("Политика конфиденциальности")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                }
                
                ZStack {
                    if let product = IAPManager.shared.getProducts().first {
                        Button(action: {
                            IAPManager.shared.purchase(
                                productID: product.productIdentifier,
                                success: {
                                    DispatchQueue.main.async {
                                        navigateToPersonaCode = true
                                        isPresented = false
                                    }
                                },
                                failure: { error in
                                    showErrorAlert(error: error)
                                }
                            )
                        }) {
                            Text("Приобрести за \(product.localizedPrice ?? "N/A")")
                                .frame(width: UIScreen.main.bounds.width * 0.95)
                                .frame(height: 50)
                                .foregroundColor(.white)
                                .cornerRadius(20)
                        }
                    } else {
                        Text("Загрузка цены...")
                            .frame(width: UIScreen.main.bounds.width * 0.95)
                            .frame(height: 50)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                    }
                    
                    OutlineGradientView()
                }
                
                Button(action: {
                    isPresented = false
                }) {
                    Text("Отмена")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.blue)
                }
                
            }
        }
        .ignoresSafeArea(edges: .top)
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

#Preview {
    PurchaseModalView(isPresented: .constant(true), navigateToPersonaCode: .constant(false))
//        .preferredColorScheme(.dark)
}
