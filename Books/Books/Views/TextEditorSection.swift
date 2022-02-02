//
//  TextEditorSection.swift
//  Books
//
//  Created by Gaurang on 06/01/22.
//

import SwiftUI

struct TextEditorSection: View {
    let title: String
    let placeholder: String
    var isRequired: Bool = true
    @Binding var value: String

    var body: some View {
        Section(header: headerView) {
            ZStack(alignment: .leading) {
                if value.isEmpty {
                    Text(placeholder)
                        .foregroundColor(Color(.placeholderText))
                        .padding(4)
                }
                TextEditor(text: $value)
                    .padding(4)
            }
        }
    }

    var headerView: AnyView {
        if isRequired && value.isEmpty {
            return Text(title).foregroundColor(.red).eraseToAnyView()
        }
        return Text(title).eraseToAnyView()
    }
}
