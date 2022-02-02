//
//  File.swift
//  InstagramDesgn
//
//  Created by Gaurang Vyas on 12/01/22.
//

import SwiftUI

enum SystemImage: String {
    case share = "square.and.arrow.up"
    case bell
    case star = "star.fill"
    case play = "play.circle"
}

extension Image {
    init(_ systemImageType: SystemImage) {
        self.init(systemName: systemImageType.rawValue)
    }
}
