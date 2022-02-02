//
//  ValidationViewModel.swift
//  SwiftUIDemo
//
//  Created by Gaurang on 20/12/21.
//

import Combine

class ValidationViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var userName: String = ""
    @Published var password: String = ""


    lazy var emailValidation: ValidationPublisher = {
        $email.matcherValidation(.email, "Inavalid email address")
    }()

    lazy var userNameValidation: ValidationPublisher = {
        $userName.matcherValidation(.username, "Invalid UserName address")
    }()

    lazy var passwordValidation: ValidationPublisher = {
        $password.matcherValidation(.email, "Password should be Minimum 8 characters at least 1 Alphabet, 1 Number and 1 Special Character")
    }()
}
