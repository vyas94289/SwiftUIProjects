//
//  LoginView.swift
//  FitnessApp
//
//  Created by Gaurang on 16/05/22.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var userSettings: UserSettings
    @StateObject var viewModel = LoginViewModel()
    @FocusState private var focus: FocusableField?
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack(spacing: 20) {
                    
                    Spacer()
                    
                    Image(app: .logo)
                    
                    Spacer().frame(height: 10)
                    
                    ThemeTextField(title: "Email",
                                   value: $viewModel.email,
                                   status: $viewModel.emailStatus)
                        .focused($focus, equals: .email)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .submitLabel(.next)
                        .onSubmit {
                            self.focus = .password
                        }
                    
                    ThemePasswordField(title: "Password",
                                       value: $viewModel.password,
                                       status: $viewModel.passwordStatus)
                        .focused($focus, equals: .password)
                        .autocapitalization(.none)
                        .submitLabel(.next)
                        .onSubmit(viewModel.doLogin)
                    
                    NavigationLink("Forgot Password?") {
                        Color(theme: .primaryLight)
                    }.foregroundColor(.gray)
                    
                    Button("Log In") {
                        viewModel.doLogin()
                    }.buttonStyle(PrimaryButtonStyle(isLoading: .constant(false)))
                        .disabled(viewModel.havingValidInputs == false)
                    
                    NavigationLink("Register") {
                        Color.red
                    }.buttonStyle(BorderButtonStyle())
                    
                    Spacer()
                }.frame(minHeight: proxy.size.height).padding(.horizontal, 40)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .navigationBarHidden(true)
        .onChange(of: viewModel.isLoggingIn) { newValue in
            if newValue {
                withAnimation {
                    userSettings.isLoggedIn = true
                }
            }
        }
    }
}

extension LoginView {
    enum FocusableField: Hashable {
        case email
        case password
    }
}

