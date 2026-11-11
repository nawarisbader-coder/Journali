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
            LinearGradient(
                stops: [
                    .init(color: .black, location: 0),
                    .init(color: Color(red: 11/255, green: 11/255, blue: 18/255), location: 0.55),
                    .init(color: Color(red: 21/255, green: 21/255, blue: 23/255), location: 1)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
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
