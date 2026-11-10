//
//  JournalCardView.swift
//  Journali
//
//  Created by Nawaris Alotaibi on 30/05/1448 AH.
//

import SwiftUI

struct JournalCardView: View {
    let journal: Journal            // "Give me one journal to show"

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {

            // Top row: title + date on the left, bookmark on the right
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(journal.title)
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundStyle(Color.textAccent)

                    Text(journal.formattedDate)
                        .font(.system(size: 14))
                        .foregroundStyle(Color.textSecondary)
                }

                Spacer()            // a squishy pillow that pushes things apart

                Image(journal.isBookmarked ? "BookmarkFill" : "Bookmark")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 24)
                    .foregroundStyle(Color.textAccent)
            }

            // The journal words
            Text(journal.content)
                .font(.system(size: 18))
                .foregroundStyle(.white)
                .lineLimit(5)       // show at most 5 lines, like the design
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.surfaceCard, in: RoundedRectangle(cornerRadius: 28))
    }
}

#Preview {
    JournalCardView(journal: Journal.samples[0])
        .padding()
        .background(Color.backgroundPrimary)
}
