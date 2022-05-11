//
//  Navigation.swift
//  SnapChatInput
//
//  Created by Gaurang on 20/04/22.
//

import SwiftUI

struct NavigationItemContainer<Content>: View where Content: View {
    private let content: () -> Content
    @Environment(\.presentationMode) var presentationMode

    private var backButton : some View {
        Button {
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "chevron.backward")
                .aspectRatio(contentMode: .fit)
            }
    }

    var body: some View {
        content()
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: backButton)
    }

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
}
