//
//  Colors.swift
//  SnapChatInput
//
//  Created by Gaurang on 19/04/22.
//

import SwiftUI

enum ThemeColor: String {
    case primary            = "ThemePrimary"
    case primaryLight       = "ThemePrimaryLight"
    case primaryExtraLight  = "ThemePrimaryExtraLight"
    case primaryDark        = "ThemePrimaryDark"
}

extension Color {
    
    init(theme: ThemeColor) {
        self.init(theme.rawValue)
    }
}
