//
//  TextFieldWithError.swift
//  SwiftUIDemo
//
//  Created by Gaurang on 23/12/21.
//

import SwiftUI

enum TextFieldTypes: String {
    case email = "Email"
    case username = "Username"
    case password = "Password"

    var keyboardType: UIKeyboardType {
        switch self {
        case .email:
            return .emailAddress
        case .username, .password:
            return .default
        }
    }

    var autocapitalization: UITextAutocapitalizationType {
        switch self {
        case .email, .username, .password:
            return .none

        }
    }

}

struct TextFieldWithError: View, Equatable {
    static func == (lhs: TextFieldWithError, rhs: TextFieldWithError) -> Bool {
        lhs.latestValidation.tag == rhs.latestValidation.tag
    }
    let validationPublisher: ValidationPublisher
    @State var latestValidation: Validation = .empty
    var type: TextFieldTypes
    @Binding var text: String
    @State var errorMessage: String = ""

    var body: some View {
        VStack(alignment: .leading) {
            Text(type.rawValue)
                .frame(maxWidth: .infinity, alignment: .leading)
            TextField(type.rawValue, text: $text, onCommit: {
                print(text)
            })
                .keyboardType(type.keyboardType)
                .autocapitalization(type.autocapitalization)
                .padding(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(self.latestValidation.color, lineWidth: 1)
                )

            if case Validation.failure(let errorMessage) = self.latestValidation {
                Text(errorMessage)
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
        .padding(.horizontal)
        .onReceive(validationPublisher) { validation in
            withAnimation {
                self.latestValidation = validation
            }
        }
    }
}

struct SecureTextFieldWithError: View, Equatable {

    static func == (lhs: SecureTextFieldWithError, rhs: SecureTextFieldWithError) -> Bool {
        lhs.latestValidation.tag == rhs.latestValidation.tag
    }

    let validationPublisher: ValidationPublisher
    @State var latestValidation: Validation = .empty
    var type: TextFieldTypes
    @Binding var text: String
    @State var errorMessage: String = ""

    var body: some View {
        VStack(alignment: .leading) {
            Text(type.rawValue)
                .frame(maxWidth: .infinity, alignment: .leading)
            SecureField(type.rawValue, text: $text)
                .keyboardType(type.keyboardType)
                .autocapitalization(type.autocapitalization)
                .padding(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(self.latestValidation.color, lineWidth: 1)
                )

            if case Validation.failure(let errorMessage) = self.latestValidation {
                Text(errorMessage)
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
        .padding(.horizontal)
        .onReceive(validationPublisher) { validation in
            withAnimation {
                self.latestValidation = validation
            }
        }
    }
}

