//
//  JournalViewModel.swift
//  Journali
//
//  Created by Nawaris Alotaibi on 01/06/1448 AH.
//

import Foundation
import SwiftUI
import Combine

class JournalViewModel: ObservableObject {
    @Published var journals: [Journal] = []

    // TEMPORARY: adds a pretend journal so we can test the screen.
    func addSampleJournal() {
        let newJournal = Journal(
            title: "New Journal",
            date: Date(),
            content: Journal.sampleText,
            isBookmarked: false
        )
        journals.append(newJournal)
    }

    func toggleBookmark(for journal: Journal) {
        if let index = journals.firstIndex(where: { $0.id == journal.id }) {
            journals[index].isBookmarked.toggle()
        }
    }
}
