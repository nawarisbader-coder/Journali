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
    @Published var sortOption: SortOption = .entryDate
    @Published var searchText: String = ""

    // Same journals, in the right order
    var sortedJournals: [Journal] {
        switch sortOption {
        case .bookmark:
            return journals.sorted { first, second in
                if first.isBookmarked != second.isBookmarked {
                    return first.isBookmarked
                }
                return first.date > second.date
            }
        case .entryDate:
            return journals.sorted { $0.date > $1.date }
        }
    }

    // Sorted, and then filtered by whatever is typed in the search bar
    var visibleJournals: [Journal] {
        let words = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        if words.isEmpty {
            return sortedJournals
        }
        return sortedJournals.filter { journal in
            journal.title.localizedCaseInsensitiveContains(words)
            || journal.content.localizedCaseInsensitiveContains(words)
        }
    }

    func addJournal(title: String, content: String) {
        let cleanTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        let newJournal = Journal(
            title: cleanTitle.isEmpty ? "Untitled" : cleanTitle,
            date: Date(),
            content: content,
            isBookmarked: false
        )
        journals.append(newJournal)
    }

    func updateJournal(_ journal: Journal, title: String, content: String) {
        if let index = journals.firstIndex(where: { $0.id == journal.id }) {
            let cleanTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
            journals[index].title = cleanTitle.isEmpty ? "Untitled" : cleanTitle
            journals[index].content = content
        }
    }

    func toggleBookmark(for journal: Journal) {
        if let index = journals.firstIndex(where: { $0.id == journal.id }) {
            journals[index].isBookmarked.toggle()
        }
    }

    func deleteJournal(_ journal: Journal) {
        journals.removeAll { $0.id == journal.id }
    }
}
