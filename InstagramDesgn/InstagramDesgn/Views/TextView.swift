//
//  TextView.swift
//  InstagramDesgn
//
//  Created by Gaurang Vyas on 13/01/22.
//

import SwiftUI
import UIKit

struct TextView: UIViewRepresentable {
    @Binding var text: String

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator

        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.isSelectable = true
        textView.isScrollEnabled = false // We want the view to resize to fit text instead of scrolling

        // Makes the text wrap rather than extend on one line outside the parent frame
        textView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        textView.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        textView.setContentHuggingPriority(.defaultHigh, for: .vertical)

        return textView
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: _text)
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
}

extension TextView {
    class Coordinator: NSObject, UITextViewDelegate {
        @Binding var text: String

        init(text: Binding<String>) {
            self._text = text
        }

        func textViewDidChange(_ textView: UITextView) {
            self.text = textView.text
        }
    }
}
