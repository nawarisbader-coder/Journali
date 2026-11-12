//
//  SortOption.swift
//  Journali
//
//  Created by Nawaris Alotaibi on 02/06/1448 AH.
//

import Foundation

enum SortOption: String, CaseIterable, Identifiable {
    case bookmark = "Sort by Bookmark"
    case entryDate = "Sort by Entry Date"

    var id: String { rawValue }
}
