//
//  AuthContentView.swift
//  SnapChatInput
//
//  Created by Gaurang on 21/04/22.
//

import SwiftUI


struct AuthContentView<Content>: View where Content: View {
    let title: String
    let subheadLine: String?
    var views: Content

    init(title: String, subheadLine: String? = nil, @ViewBuilder content: () -> Content) {
        self.title = title
        self.subheadLine = subheadLine
        self.views = content()
    }

    var body: some View {
        NavigationItemContainer {
            VStack {
                
                Text(title).authTitleStyle()
                
                if let subheadLine = subheadLine {
                    Text(subheadLine).authSubheadLineStyle().padding(.top, 2)
                }
                
                views.padding(.top, 10)
                
            }.padding(.horizontal, 50)
        }
        .navigationBarHidden(false)
    }
}
