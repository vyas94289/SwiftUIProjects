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
    @Published var password: String = ""
    @Published var passwordErrorMessage: String?
    @Published var saveInfo: Bool = true
    @Published var havingInvalidInputs = false
    @Published var isLoggingIn = false
    
    private var disposeBag = Set<AnyCancellable>()
    
    init() {
        observeInputs()
    }
    
    private func observeInputs() {
        Publishers.CombineLatest($email, $password).sink(receiveValue: { (email, password) in
            let isInvalid = email.isEmpty || password.isEmpty
            if self.havingInvalidInputs != isInvalid {
                self.havingInvalidInputs = isInvalid
            }
            if self.passwordErrorMessage != nil {
                self.passwordErrorMessage = nil
            }
        }).store(in: &disposeBag)
    }
    
    func doLogin() {
        withAnimation {
            self.isLoggingIn = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation {
                self.isLoggingIn = false
                self.passwordErrorMessage = "We cannot find a matching username"
            }
            
        }
    }
}
