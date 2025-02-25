//
//  IAPManager.swift
//  Persona Code
//
//  Created by Иван Семикин on 25/02/2025.
//

import Foundation
import StoreKit

final class IAPManager: NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    static let shared = IAPManager()
    private var products: [SKProduct] = []
    
    var onPurchaseSuccess: (() -> Void)?
    var onPurchaseFailure: ((Error?) -> Void)?

    func fetchProducts() {
        let productIdentifiers: Set<String> = ["persona.code"]
        let request = SKProductsRequest(productIdentifiers: productIdentifiers)
        request.delegate = self
        request.start()
    }
    
    func getProducts() -> [SKProduct] {
        return products
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        products = response.products
    }
    
    func purchase(productID: String, success: @escaping () -> Void, failure: @escaping (Error?) -> Void) {
        guard let product = products.first(where: { $0.productIdentifier == productID }) else { return }
        
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased:
                SKPaymentQueue.default().finishTransaction(transaction)
                onPurchaseSuccess?()
            case .failed:
                let errorMessage = transaction.error?.localizedDescription ?? "Transaction was cancelled by user"
                SKPaymentQueue.default().finishTransaction(transaction)
                onPurchaseFailure?(transaction.error)
            default:
                break
            }
        }
    }
    
    func restorePurchases() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    func startObserving() {
        SKPaymentQueue.default().add(self)
    }
    
    func stopObserving() {
        SKPaymentQueue.default().remove(self)
    }
}

extension SKProduct {
    var localizedPrice: String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = priceLocale
        return formatter.string(from: price)
    }
}
