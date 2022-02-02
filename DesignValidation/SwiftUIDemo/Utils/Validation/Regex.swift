//
//  Regex.swift
//  SwiftUIDemo
//
//  Created by Gaurang on 21/12/21.
//

import Foundation
import SwiftUI

enum Regex {
    case email
    case username
    case password

    var pattern: String {
        switch self {
        case .email:
            return "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,15}"
        case .username:
            return "^[0-9a-zA-Z\\_]{7,18}$"
        case .password:
            return "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$"
        }
    }

    func isValid(value: String) -> TextFieldStatus {
        if value.isEmpty {
            return .empty
        }
        let emailPred =  NSPredicate(format:"SELF MATCHES %@", self.pattern)
        if emailPred.evaluate(with: value) {
            return .valid
        } else {
            return .invalid
        }
    }
}

enum TextFieldStatus {
    case empty, valid, invalid
}
