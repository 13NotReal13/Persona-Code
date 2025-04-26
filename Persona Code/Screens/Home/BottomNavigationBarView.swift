//
//  BottomNavigationBarView.swift
//  Persona Code
//
//  Created by Иван Семикин on 23/02/2025.
//

import SwiftUI

struct BottomNavigationBarView: View {
    @EnvironmentObject private var coordinator: NavigationCoordinator
    
    @State private var showUpdateAlert = false
    
    @AppStorage("lastUpdateCheckDate") private var lastUpdateCheckDate: Double = 0
    @AppStorage("hasSkippedUpdateOnce") private var hasSkippedUpdateOnce: Bool = false
    
    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            
            Button {
                coordinator.push(.enterData)
            } label: {
                ButtonLabelView(text: "Persona Code", fontSize: 17, widthMultiplyBy: 0.8)
            }
            
            Button {
                coordinator.push(.affirmation)
            } label: {
                ButtonLabelView(text: "Affirmations", fontSize: 17, widthMultiplyBy: 0.75)
            }
            
            Button {
                coordinator.push(.history)
            } label: {
                ButtonLabelView(text: "History", fontSize: 17, widthMultiplyBy: 0.70)
            }
            
            Button {
                coordinator.push(.settings)
            } label: {
                ButtonLabelView(text: "Settings", fontSize: 17, widthMultiplyBy: 0.65)
            }
            
            Button {
                coordinator.push(.helpInfo)
            } label: {
                ButtonLabelView(text: "How does it work?", fontSize: 17, widthMultiplyBy: 0.6)
            }
        }
        .padding()
        .onAppear {
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
        .background(BackgroundView())
}
