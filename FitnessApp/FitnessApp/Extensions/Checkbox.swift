//
//  Checkbox.swift
//  SnapChatInput
//
//  Created by Gaurang on 20/04/22.
//

import SwiftUI

struct CheckBox: View {
    @Binding var isChecked: Bool
    let title: String
    var body: some View {
        Button(action: {
            self.isChecked.toggle()
        }, label: {
            HStack {
                Image(systemName: isChecked ? "checkmark.square" : "square")
                Text(title)
                    .foregroundColor(.init(theme: .primary))
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }).frame(maxWidth: .infinity)
    }
}
