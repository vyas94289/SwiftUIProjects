//
//  Text+Style.swift
//  SnapChatInput
//
//  Created by Gaurang on 21/04/22.
//

import Foundation
import SwiftUI

struct ErrorTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
        .font(.caption)
        .foregroundColor(.themeRed)
        .transition(.move(edge: .leading))
    }
}


extension Text {
    
    func errorStyle() -> some View {
        modifier(ErrorTextModifier())
    }
    
    func authTitleStyle() -> some View {
        self.foregroundColor(.themeBlack)
            .fontWeight(.semibold)
            .multilineTextAlignment(.center)
    }
    
    func authSubheadLineStyle() -> some View {
        self.foregroundColor(.themeGray)
            .font(.footnote)
            .multilineTextAlignment(.center)
    }
}
