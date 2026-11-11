//
//  EmptyStateView.swift
//  Journali
//
//  Created by Nawaris Alotaibi on 01/06/1448 AH.
//

import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 12) {
            Image("Splash")
                .resizable()
                .scaledToFit()
                .frame(width: 180)

            Text("Begin Your Journal")
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(Color.textAccent)

            Text("Craft your personal diary, tap the plus icon to begin")
                .font(.system(size: 18))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 50)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ZStack {
        Color.backgroundPrimary.ignoresSafeArea()
        EmptyStateView()
    }
}
