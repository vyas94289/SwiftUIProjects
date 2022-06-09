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
    case lightGray          = "ThemeLightGray"
    case extraLightGray     = "ThemeExtraLightGray"
    case darkGray           = "ThemeDarkGray"
}

extension Color {
    
    init(theme: ThemeColor) {
        self.init(theme.rawValue)
    }
}
