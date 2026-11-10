//
//  SplashView.swift
//  Journali
//
//  Created by Nawaris Alotaibi on 30/05/1448 AH.
//
import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {                                   
            Color.backgroundPrimary
                .ignoresSafeArea()
            VStack(spacing: 12) {
                Image("AppLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)

                Text("Journali")
                    .font(.system(size: 42, weight: .black))
                    .foregroundStyle(.white)

                Text("Your thoughts, your story")
                    .font(.system(size: 18, weight: .light))
                    .foregroundStyle(Color.textSecondary)
            }
        }
    }
}

#Preview {
    SplashView()
}
