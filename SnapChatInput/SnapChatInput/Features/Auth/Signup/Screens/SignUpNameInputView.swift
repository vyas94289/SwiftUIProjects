//
//  SignUpNameInputView.swift
//  SnapChatInput
//
//  Created by Gaurang on 21/04/22.
//

import SwiftUI

struct SignUpNameInputView: View {
    @StateObject var viewModel = SignupViewInfoModel()
    @FocusState private var focus: FocusableField?
    @State private var pushToBirthDate: Bool = false
    
    var body: some View {
        AuthContentView(title: "What's your name?") {
            
            NavigationLink(destination: SignupDOBInputView().environmentObject(viewModel), isActive: $pushToBirthDate) {
                EmptyView()
                }.hidden()
            
            ThemeTextField(title: "First name", value: $viewModel.firstName, errorMessage: .constant(nil))
                .padding(.top, 20)
                .focused($focus, equals: .firstName)
                .submitLabel(.next)
                .onSubmit {
                    self.focus = .firstName
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.focus = .firstName
                    }
                }
            
            ThemeTextField(title: "Last name", value: $viewModel.lastName, errorMessage: .constant(nil))
                .padding(.top, 4)
                .focused($focus, equals: .lastName)
                .submitLabel(.next)
                .onSubmit(submit)
            
            Text("By tapping Sign Up & Accept, you acknowledge that you have read the [Privacy Policy](https://example.com) and agree to the [Terms of Service](www.google.com).")
                .font(.caption)
                .padding(.top, 6)
            
            Spacer()
            
            PrimaryButton(title: "Signup Up & Accept",
                          isProcessing: .constant(false),
                          action: submit)
                .disabled(!viewModel.isValidName)
                .padding(.vertical, 12)
                .padding(.horizontal, 40)
        }
    }
    
    private func submit() {
        pushToBirthDate = true
    }
}

extension SignUpNameInputView {
    enum FocusableField: Hashable {
      case firstName
      case lastName
    }
}

struct SignUpNameInputView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpNameInputView()
    }
}
