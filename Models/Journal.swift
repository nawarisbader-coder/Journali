//
//  Journal.swift
//  Journali
//
//  Created by Nawaris Alotaibi on 30/05/1448 AH.
//

import Foundation

struct Journal: Identifiable {
    let id = UUID()
    var title: String
    var date: Date
    var content: String
    var isBookmarked: Bool

    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: date)
    }
}

extension Journal {
    static let sampleDate = DateComponents(calendar: .current, year: 2024, month: 9, day: 2).date ?? Date()
    static let sampleText = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio. Quisque volutpat mattis eros. Nullam malesuada erat ut turpis. Suspendisse urna nibh viverra non"

    static let samples: [Journal] = [
        Journal(title: "My Birthday", date: sampleDate, content: sampleText, isBookmarked: true),
        Journal(title: "Today's Journal", date: sampleDate, content: sampleText, isBookmarked: false),
        Journal(title: "Great Day", date: sampleDate, content: sampleText, isBookmarked: false)
    ]
}
