//
//  PasswordValidation.swift
//  SnapChatInput
//
//  Created by Gaurang on 02/05/22.
//

import Combine
import SwiftUI
import Foundation

class PasswordValidaton: ObservableObject {
    @Published var value: String = ""
    @Published var isValid: Bool = false
    @Published var leastChars: Bool = false
    @Published var containUpperCase: Bool = false
    @Published var containSymbol: Bool = false
    
    private var cancellable: AnyCancellable?

    init() {
        observeValidation()
    }
    
    private func observeValidation() {
        cancellable = $value
            .sink { value in
                withAnimation {
                    var isValid = true
                    if value.isEmpty {
                        isValid = false
                    }
                    if value.count < 8 {
                        isValid = false
                        self.leastChars = false
                    } else {
                        self.leastChars = true
                    }
                    if value.containUppercaseLetter == false {
                        isValid = false
                        self.containUpperCase = false
                    } else {
                        self.containUpperCase = true
                    }
                    if value.containNumberOrSymbols == false {
                        isValid = false
                        self.containSymbol = false
                    } else {
                        self.containSymbol = true
                    }
                    self.isValid = isValid
                }
                
            }
    }
}

extension String {
    
    var containUppercaseLetter: Bool {
        let capitalLetterRegEx  = ".*[A-Z]+.*"
        let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        return texttest.evaluate(with: self)
    }
    
    var containNumberOrSymbols: Bool {
        range(of: ".*[^A-Za-z].*", options: .regularExpression) != nil
    }
}
