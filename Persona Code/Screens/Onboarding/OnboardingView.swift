//
//  OnboardingView.swift
//  Persona Code
//
//  Created by Иван Семикин on 25/03/2025.
//

import SwiftUI

struct OnboardingView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var currentPage = 0

    var body: some View {
        VStack(spacing: 16) {
            TabView(selection: $currentPage) {
                OnboardingPageOneView().tag(0)
                OnboardingPageTwoView().tag(1)
                OnboardingPageThreeView().tag(2)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .animation(.easeInOut, value: currentPage)

            // Нижняя панель
            VStack {
                HStack {
                    Spacer()
                    HStack(spacing: 8) {
                        ForEach(0..<3) { index in
                            Circle()
                                .fill(index == currentPage ? Color.white : Color.white.opacity(0.3))
                                .frame(width: 8, height: 8)
                        }
                    }
                    Spacer()
                }
                .padding(.bottom, 16)

                Button(action: {
                    withAnimation {
                        if currentPage < 2 {
                            currentPage += 1
                        } else {
                            UserDefaults.standard.set(true, forKey: "onboardingWasShowing")
                            dismiss()
                        }
                    }
                }) {
                    ButtonLabelView(
                        text: currentPage < 2 ? "Continue" : "Start",
                        fontSize: 17,
                        widthMultiplyBy: 0.6
                    )
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    withAnimation {
                        currentPage -= 1
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .customText(fontSize: 17)
                        .padding()
                }
                .opacity(currentPage > 0 ? 1 : 0)
                .disabled(currentPage == 0)
            }
        }
        .background(BackgroundView(shadowLevel: .high))
    }
}

#Preview {
    NavigationStack {
        OnboardingView()
            .preferredColorScheme(.dark)
    }
}

