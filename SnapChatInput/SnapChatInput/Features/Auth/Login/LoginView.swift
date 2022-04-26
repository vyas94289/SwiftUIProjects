//
//  LoginView.swift
//  SnapChatInput
//
//  Created by Gaurang on 19/04/22.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    @State var showForgotPassword = false
    @FocusState private var focus: FocusableField?
    
    var body: some View {
        AuthContentView(title: "Log In") {
            ThemeTextField(title: "Username or Email", value: $viewModel.email, errorMessage: .constant(nil))
                .padding(.top, 20)
                .focused($focus, equals: .email)
                .keyboardType(.emailAddress)
                .submitLabel(.next)
                .onSubmit {
                    self.focus = .password
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.focus = .email
                    }
                }
            
            ThemePasswordField(title: "Password", value: $viewModel.password, errorMessage: $viewModel.passwordErrorMessage)
                .padding(.top, 4)
                .focused($focus, equals: .password)
                .submitLabel(.next)
                .onSubmit(viewModel.doLogin)
            
            CheckBox(isChecked: $viewModel.saveInfo, title: "Save Login Info on your iCloud devices").padding(.top, 8)
            
            Button("Forgot your password?") {
                self.showForgotPassword.toggle()
            }
            .padding(.top, 12)
            .font(.caption)
            
            Spacer()
            
            PrimaryButton(title: "Login",
                          isProcessing: $viewModel.isLoggingIn,
                          action: viewModel.doLogin)
                .disabled(viewModel.havingInvalidInputs || viewModel.isLoggingIn)
                .padding(.vertical, 12)
                .padding(.horizontal, 40)
        }
        .fullScreenCover(isPresented: $showForgotPassword) {
            ForgotPasswordPopUp().background(BackgroundCleanerView())
        }
        
    }
}

extension LoginView {
    enum FocusableField: Hashable {
      case email
      case password
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
