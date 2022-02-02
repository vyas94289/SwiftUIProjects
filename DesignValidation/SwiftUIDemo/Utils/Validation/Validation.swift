//
//  Validation.swift
//  SwiftUI-Validation
//
//  Created by Jack Newcombe on 01/03/2020.
//  Copyright © 2020 Jack Newcombe. All rights reserved.
//

import Foundation
import SwiftUI

enum Validation {
    case empty
    case success
    case failure(message: String)
    
    var isSuccess: Bool {
        if case .success = self {
            return true
        }
        return false
    }

    var color: Color {
        switch self {
        case .empty:
            return Color(Colors.purpleColor)
        case .success:
            return Color.green
        case .failure:
            return Color.red
        }
    }

    var tag: Int {
        switch self {
        case .empty:
            return 0
        case .success:
            return 1
        case .failure:
            return 3
        }
    }
}
