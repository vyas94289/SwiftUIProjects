//
//  UsernameInputView.swift
//  SnapChatInput
//
//  Created by Gaurang on 21/04/22.
//

import Foundation
import SwiftUI

struct UsernameInputView: View {
    @EnvironmentObject var viewModel: SignupViewInfoModel
    @State private var pushToPassword: Bool = false
    @FocusState private var focus: Bool?
    
    var body: some View {
        AuthContentView(title: "Pick a username", subheadLine: "Your username is how friends add you on Snapchat.") {
            
            NavigationLink(destination: PasswordInputView(), isActive: $pushToPassword) {
                EmptyView()
                }.hidden()
            
            ThemeTextField(title: "Username", value: $viewModel.username, errorMessage: .constant(nil))
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
            HStack(spacing: 4) {
                if viewModel.usernameStatus.isLoading {
                    ProgressView()
                }
                if let message = viewModel.usernameStatus.message {
                    Text(message).font(.caption).foregroundColor(viewModel.usernameStatus.textColor)
                }
                Spacer()
            }
            
            
            Spacer()
            
            PrimaryButton(title: "Continue",
                          isProcessing: .constant(false),
                          action: submit)
                .padding(.vertical, 12)
                .padding(.horizontal, 40)
                .disabled(viewModel.usernameStatus.isValid == false)
            
        
        }.padding(.top, 100)
    }
    private func submit() {
        self.pushToPassword = true
    }
}
