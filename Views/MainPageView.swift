//
//  MainPageView.swift
//  Journali
//
//  Created by Nawaris Alotaibi on 30/05/1448 AH.
//

import SwiftUI

struct MainPageView: View {
    @StateObject private var viewModel = JournalViewModel()

    @State private var showNewJournal = false
    @State private var journalToEdit: Journal?
    @State private var journalToDelete: Journal?

    var body: some View {
        NavigationStack {
            ZStack {
                Color.backgroundPrimary
                    .ignoresSafeArea()

                if viewModel.journals.isEmpty {
                    EmptyStateView()
                } else if viewModel.visibleJournals.isEmpty {
                    ContentUnavailableView.search(text: viewModel.searchText)
                } else {
                    List {
                        ForEach(viewModel.visibleJournals) { journal in
                            JournalCardView(journal: journal) {
                                viewModel.toggleBookmark(for: journal)
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                journalToEdit = journal
                            }
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20))
                            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                Button {
                                    journalToDelete = journal
                                } label: {
                                    Image("Trash")
                                        .renderingMode(.template)
                                }
                                .tint(Color.destructive)
                            }
                        }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    .scrollDismissesKeyboard(.interactively)
                    .animation(.default, value: viewModel.sortOption)
                }
            }
            .safeAreaInset(edge: .bottom) {
                searchBar
            }
            .navigationTitle("Journal")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Menu {
                        Picker("Sort", selection: $viewModel.sortOption) {
                            ForEach(SortOption.allCases) { option in
                                Text(option.rawValue).tag(option)
                            }
                        }
                    } label: {
                        Image("Filter")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 22, height: 22)
                    }

                    Button {
                        showNewJournal = true
                    } label: {
                        Image("Plus")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 22, height: 22)
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
        // New Journal sheet
        .sheet(isPresented: $showNewJournal) {
            JournalEditorView { title, content in
                viewModel.addJournal(title: title, content: content)
            }
            .presentationDragIndicator(.visible)
        }
        // Edit Journal sheet
        .sheet(item: $journalToEdit) { journal in
            JournalEditorView(journal: journal) { title, content in
                viewModel.updateJournal(journal, title: title, content: content)
            }
            .presentationDragIndicator(.visible)
        }
        // Delete alert
        .alert(
            "Delete Journal?",
            isPresented: Binding(
                get: { journalToDelete != nil },
                set: { isShowing in
                    if !isShowing { journalToDelete = nil }
                }
            ),
            presenting: journalToDelete
        ) { journal in
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                withAnimation {
                    viewModel.deleteJournal(journal)
                }
            }
        } message: { _ in
            Text("Are you sure you want to delete this journal?")
        }
    }

    // The search bar: magnifier + text box
    private var searchBar: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 18))
                .foregroundStyle(Color.textSecondary)

            TextField(
                "Search",
                text: $viewModel.searchText,
                prompt: Text("Search").foregroundStyle(Color.textSecondary)
            )
            .font(.system(size: 18))
            .foregroundStyle(.white)
            .tint(Color.primaryAccent)
            .submitLabel(.search)

            if !viewModel.searchText.isEmpty {
                Button {
                    viewModel.searchText = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(Color.textSecondary)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .glassEffect(.regular, in: .capsule)
        .padding(.horizontal, 20)
        .padding(.bottom, 8)
    }
}

#Preview {
    MainPageView()
}
