//
//  BottomNavigationBarView.swift
//  Persona Code
//
//  Created by Иван Семикин on 23/02/2025.
//

import SwiftUI

struct BottomNavigationBarView: View {
    @EnvironmentObject private var coordinator: NavigationCoordinator
    
    @AppStorage("hasOpenedHowItWorks") private var hasOpenedHowItWorks: Bool = false
    @State private var howDoesItWorkIsAnimating = false
    @State private var showUpdateAlert = false
    
    @AppStorage("lastUpdateCheckDate") private var lastUpdateCheckDate: Double = 0
    @AppStorage("hasSkippedUpdateOnce") private var hasSkippedUpdateOnce: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            
            Button {
                coordinator.push(.enterData)
            } label: {
                Text("Persona Code")
                    .customText(fontSize: 17)
                    .customButtonStyle(width: UIScreen.main.bounds.width * 0.7, shape: .capsule)
            }
            
            Button {
                coordinator.push(.affirmation)
            } label: {
                Text("Affirmations")
                    .customText(fontSize: 17)
                    .customButtonStyle(width: UIScreen.main.bounds.width * 0.65, shape: .capsule)
            }
            
            Button {
                coordinator.push(.history)
            } label: {
                Text("History")
                    .customText(fontSize: 17)
                    .customButtonStyle(width: UIScreen.main.bounds.width * 0.6, shape: .capsule)
            }
            
            Button {
                coordinator.push(.settings)
            } label: {
                Text("Settings")
                    .customText(fontSize: 17)
                    .customButtonStyle(width: UIScreen.main.bounds.width * 0.55, shape: .capsule)
            }
            
            Button {
                hasOpenedHowItWorks = true
                coordinator.push(.helpInfo)
            } label: {
                Text("How does it work?")
                    .customText(fontSize: 17)
                    .customButtonStyle(width: UIScreen.main.bounds.width * 0.5, shape: .capsule)
                    .scaleEffect(!hasOpenedHowItWorks && howDoesItWorkIsAnimating ? 1.05 : 1)
                    .shadow(color: !hasOpenedHowItWorks ? .white.opacity(0.7) : .clear, radius: 8)
            }
        }
        .padding()
        .onAppear {
            if !hasOpenedHowItWorks {
                withAnimation(Animation.easeInOut(duration: 1).repeatForever()) {
                    howDoesItWorkIsAnimating = true
                }
            }
            
            let now = Date().timeIntervalSince1970
            let hoursPassed = (now - lastUpdateCheckDate) / 3600

            if !hasSkippedUpdateOnce || hoursPassed >= 24 {
                checkForUpdate { updateIsAvailable in
                    if updateIsAvailable {
                        showUpdateAlert = true
                    }
                }
            }
        }
        .alert("New Version Available", isPresented: $showUpdateAlert) {
            Button("Update") {
                if let url = URL(string: "https://apps.apple.com/pl/app/persona-code/id6742420405") {
                    UIApplication.shared.open(url)
                }
            }
            Button("Later", role: .cancel) {
                lastUpdateCheckDate = Date().timeIntervalSince1970
                hasSkippedUpdateOnce = true
            }
        } message: {
            Text("Please update the app to the latest version.")
        }
    }
    
    private func checkForUpdate(completion: @escaping (Bool) -> Void) {
        guard let bundleId = Bundle.main.bundleIdentifier else { return }
        
        let url = URL(string: "https://itunes.apple.com/lookup?bundleId=\(bundleId)")!
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let results = json["results"] as? [[String: Any]],
                  let appStoreVersion = results.first?["version"] as? String,
                  let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
            else {
                completion(false)
                return
            }

            DispatchQueue.main.async {
                completion(appStoreVersion.compare(currentVersion, options: .numeric) == .orderedDescending)
            }
        }.resume()
    }
}

#Preview {
    BottomNavigationBarView()
}
