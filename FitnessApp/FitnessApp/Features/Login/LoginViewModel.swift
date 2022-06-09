//
//  LoginViewModel.swift
//  SnapChatInput
//
//  Created by Gaurang on 20/04/22.
//

import Combine
import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var emailStatus: InputStatus = .idle
    @Published var password: String = ""
    @Published var passwordStatus: InputStatus = .idle
    @Published var havingValidInputs = false
    @Published var isLoggingIn = false
    
    @Published var emailModel = TextFieldObserver("Email", validator: .email)
    
    private var disposeBag = Set<AnyCancellable>()
    
    init() {
        observeInputs()
    }
    
    private func observeInputs() {
        $email
            .dropFirst()
            .debounce(for: .milliseconds(1000), scheduler: RunLoop.main)
            .sink { value in
                let result = InputValidation.email.isValid(input: value, field: "Email")
                withAnimation(.easeInOut) {
                    if result.isValid {
                        self.emailStatus = .valid
                    } else if let error = result.error {
                        self.emailStatus = .invalid(message: error)
                    }
                }
            }.store(in: &disposeBag)
        
        $password
            .dropFirst()
            .debounce(for: .milliseconds(1000), scheduler: RunLoop.main)
            .sink { value in
                let result = InputValidation.password.isValid(input: value, field: "Password")
                withAnimation(.easeInOut) {
                    if result.isValid {
                        self.passwordStatus = .valid
                    } else if let error = result.error {
                        self.passwordStatus = .invalid(message: error)
                    }
                }
            }.store(in: &disposeBag)
        
        Publishers.CombineLatest($emailStatus, $passwordStatus)
            .map({$0.0.isValid && $0.1.isValid})
            .assign(to: &$havingValidInputs)
        
    }
    
    func doLogin() {
        isLoggingIn = true
    }
}
