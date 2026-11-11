//
//  MainPageView.swift
//  Journali
//
//  Created by Nawaris Alotaibi on 30/05/1448 AH.
//

import SwiftUI

struct MainPageView: View {
    @StateObject private var viewModel = JournalViewModel()

    var body: some View {
        ZStack {
            Color.backgroundPrimary
                .ignoresSafeArea()

            VStack(spacing: 0) {

                HStack {
                    Text("Journal")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundStyle(.white)

                    Spacer()

                    HStack(spacing: 20) {
                        Button {
                            // Day 7: sort menu goes here
                        } label: {
                            Image("Filter")
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 22, height: 22)
                                .foregroundStyle(.white)
                        }

                        Button {
                            viewModel.addSampleJournal()   // temporary!
                        } label: {
                            Image("Plus")
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 22, height: 22)
                                .foregroundStyle(.white)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(Color.surfaceCard, in: Capsule())
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 16)

                if viewModel.journals.isEmpty {
                    EmptyStateView()
                } else {
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(viewModel.journals) { journal in
                                JournalCardView(journal: journal) {
                                    viewModel.toggleBookmark(for: journal)
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                }
            }
        }
    }
}

#Preview {
    MainPageView()
}
