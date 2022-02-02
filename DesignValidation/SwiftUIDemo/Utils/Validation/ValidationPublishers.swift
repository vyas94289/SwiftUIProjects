//
//  ValidationPublishers.swift
//  SwiftUI-Validation
//
//  Created by Jack Newcombe on 01/03/2020.
//  Copyright © 2020 Jack Newcombe. All rights reserved.
//

import Foundation
import Combine

typealias ValidationErrorClosure = () -> String

typealias ValidationPublisher = AnyPublisher<Validation, Never>

class ValidationPublishers {

    // Validates whether a string property is non-empty.
    static func nonEmptyValidation(for publisher: Published<String>.Publisher,
                                   errorMessage: @autoclosure @escaping ValidationErrorClosure) -> ValidationPublisher {
        return publisher.map { value in
            guard value.count > 0 else {
                return .failure(message: errorMessage())
            }
            return .success
        }
        .dropFirst()
        .eraseToAnyPublisher()
    }
    
    // Validates whether a string matches a regular expression.
    static func matcherValidation(for publisher: Published<String>.Publisher,
                                  withPattern pattern: Regex,
                                  errorMessage: @autoclosure @escaping ValidationErrorClosure) -> ValidationPublisher {
        return publisher.map { value in
            switch pattern.isValid(value: value) {
            case .empty:
                return .empty
            case .valid:
                return .success
            case .invalid:
                return .failure(message: errorMessage())
            }
        }
        .dropFirst()
        .eraseToAnyPublisher()
    }

}
