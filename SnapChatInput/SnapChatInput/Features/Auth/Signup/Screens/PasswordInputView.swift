//
//  PasswordInputView.swift
//  SnapChatInput
//
//  Created by Gaurang on 29/04/22.
//

import SwiftUI

struct PasswordInputView: View {
    @EnvironmentObject var viewModel: SignupViewInfoModel
    @State private var pushToMobile: Bool = false
    @FocusState private var focus: Bool?
    
    var body: some View {
        AuthContentView(title: "Set a password", subheadLine: "Your password should be at least 8 characters.") {
            
            NavigationLink(destination: MobileInputView(), isActive: $pushToMobile) {
                EmptyView()
                }.hidden()
            
            ThemePasswordField(title: "Password",
                               value: $viewModel.passwordModel.value,
                               errorMessage: $viewModel.passwordErrorMessage)
                .padding(.top, 20)
                .textInputAutocapitalization(.never)
                .focused($focus, equals: true)
                .submitLabel(.next)
                .onSubmit(submit)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.focus = true
                    }
                }
            
            PasswordValidationView(passwordModel: $viewModel.passwordModel)
            
            Spacer()
            
            PrimaryButton(title: "Continue",
                          isProcessing: .constant(false),
                          action: submit)
                .padding(.vertical, 12)
                .padding(.horizontal, 40)
                .disabled(viewModel.passwordModel.isValid == false)
            
        
        }.padding(.top, 100)
    }
    
    private func submit() {
        self.pushToMobile = true
    }
}

struct PasswordValidationView: View {
    @Binding var passwordModel: PasswordValidaton
    
    var body: some View {
        VStack(spacing: 6) {
            ValidationMessageText(title: "At least 8 characters", isValid: $passwordModel.leastChars)
            ValidationMessageText(title: "Must Contain an upppercase letter", isValid: $passwordModel.containUpperCase)
            ValidationMessageText(title: "Containing a symbol or number", isValid: $passwordModel.containSymbol)
        }
    }
}

struct ValidationMessageText: View {
    let title: String
    @Binding var isValid: Bool
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark.circle.fill")
            
            Text(title)
                .font(.caption)
                .strikethrough(isValid)
                .frame(maxWidth: .infinity, alignment: .leading)
                
            
        }.foregroundColor(isValid ? .green : .gray.opacity(0.5)).animation(.default, value: isValid)
    }
}
