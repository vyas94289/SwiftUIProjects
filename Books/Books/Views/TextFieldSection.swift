//
//  TextFieldSection.swift
//  Books
//
//  Created by Gaurang on 06/01/22.
//

import SwiftUI

struct TextFieldSection: View {
    let title: String
    let placeholder: String
    var isRequired: Bool = true
    @Binding var value: String

    var body: some View {
        Section(header: headerView) {
            TextField(placeholder, text: $value)
        }
    }

    var headerView: AnyView {
        if isRequired && value.isEmpty {
            return Text(title).foregroundColor(.red).eraseToAnyView()
        }
        return Text(title).eraseToAnyView()
    }
}
