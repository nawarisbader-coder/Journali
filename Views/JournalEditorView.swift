//
//  JournalEditorView.swift
//  Journali
//
//  Created by Nawaris Alotaibi on 02/06/1448 AH.
//

import SwiftUI

struct JournalEditorView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var title: String
    @State private var content: String
    @State private var showDiscardDialog = false
    @FocusState private var focusedField: Field?

    private let initialTitle: String
    private let initialContent: String
    private let date: Date
    private let isNew: Bool
    private let onSave: (String, String) -> Void

    enum Field {
        case title
        case content
    }

    // journal is an Optional: nil means "brand new journal"
    init(journal: Journal? = nil, onSave: @escaping (String, String) -> Void) {
        let startTitle = journal?.title ?? ""
        let startContent = journal?.content ?? ""

        _title = State(initialValue: startTitle)
        _content = State(initialValue: startContent)
        initialTitle = startTitle
        initialContent = startContent
        date = journal?.date ?? Date()
        isNew = (journal == nil)
        self.onSave = onSave
    }

    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: date)
    }

    private var canSave: Bool {
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        || !content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    // Did the person change anything since opening?
    private var hasChanges: Bool {
        title != initialTitle || content != initialContent
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {

            HStack {
                // X button
                Button {
                    if hasChanges {
                        showDiscardDialog = true
                    } else {
                        dismiss()
                    }
                } label: {
                    Image("Xmark")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                        .foregroundStyle(.white)
                        .frame(width: 50, height: 50)
                        .background(Color.backgroundPrimary.opacity(0.6), in: Circle())
                }
                .buttonStyle(.plain)
                .confirmationDialog(
                    "Are you sure you want to discard changes on this journal?",
                    isPresented: $showDiscardDialog,
                    titleVisibility: .visible
                ) {
                    Button("Discard Changes", role: .destructive) {
                        dismiss()
                    }
                    Button("Keep Editing", role: .cancel) { }
                }

                Spacer()

                // Checkmark button
                Button {
                    onSave(title, content)
                    dismiss()
                } label: {
                    Image("Checked")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.black)
                        .frame(width: 50, height: 50)
                        .background(Color.primaryAccent, in: Circle())
                }
                .buttonStyle(.plain)
                .disabled(!canSave)
                .opacity(canSave ? 1 : 0.5)
            }

            // Title and date
            VStack(alignment: .leading, spacing: 4) {
                TextField(
                    "Title",
                    text: $title,
                    prompt: Text("Title").foregroundStyle(Color.textSecondary.opacity(0.5))
                )
                .font(.system(size: 34, weight: .bold))
                .foregroundStyle(.white)
                .tint(Color.primaryAccent)
                .focused($focusedField, equals: .title)
                .submitLabel(.next)
                .onSubmit { focusedField = .content }

                Text(formattedDate)
                    .font(.system(size: 14))
                    .foregroundStyle(Color.textSecondary)
            }

            // The big writing area
            ZStack(alignment: .topLeading) {
                if content.isEmpty {
                    Text("Type your Journal...")
                        .font(.system(size: 20))
                        .foregroundStyle(Color.textSecondary.opacity(0.5))
                        .padding(.top, 8)
                        .padding(.leading, 5)
                }

                TextEditor(text: $content)
                    .font(.system(size: 20))
                    .foregroundStyle(.white)
                    .tint(Color.primaryAccent)
                    .scrollContentBackground(.hidden)
                    .focused($focusedField, equals: .content)
                    .scrollDismissesKeyboard(.interactively)
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 24)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.surfaceCard.ignoresSafeArea())
        .interactiveDismissDisabled(hasChanges)
        .task {
            focusedField = isNew ? .title : .content
        }
    }
}

#Preview {
    JournalEditorView { _, _ in }
}
