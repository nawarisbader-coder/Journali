//
//  MainPageView.swift
//  Journali
//
//  Created by Nawaris Alotaibi on 30/05/1448 AH.
//

import SwiftUI

struct MainPageView: View {
    var body: some View {
        ZStack {
            Color.backgroundPrimary
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 16) {

                    Text("Journal")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundStyle(.white)

                    ForEach(Journal.samples) { journal in
                        JournalCardView(journal: journal)
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

#Preview {
    MainPageView()
}
