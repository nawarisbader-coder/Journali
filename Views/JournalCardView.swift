//
//  JournalCardView.swift
//  Journali
//
//  Created by Nawaris Alotaibi on 30/05/1448 AH.
//

import SwiftUI

struct JournalCardView: View {
    let journal: Journal
    let onBookmarkTap: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {

            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(journal.title)
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundStyle(Color.textAccent)

                    Text(journal.formattedDate)
                        .font(.system(size: 14))
                        .foregroundStyle(Color.textSecondary)
                }

                Spacer()

                Button {
                    onBookmarkTap()
                } label: {
                    Image(systemName: journal.isBookmarked ? "bookmark.fill" : "bookmark")
                        .font(.system(size: 22))
                        .foregroundStyle(Color.textAccent)
                }
                .buttonStyle(.plain)
            }

            Text(journal.content)
                .font(.system(size: 18))
                .foregroundStyle(.white)
                .lineLimit(5)
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.surfaceCard, in: RoundedRectangle(cornerRadius: 28))
    }
}

#Preview {
    JournalCardView(journal: Journal.samples[0], onBookmarkTap: {})
        .padding()
        .background(Color.backgroundPrimary)
}
