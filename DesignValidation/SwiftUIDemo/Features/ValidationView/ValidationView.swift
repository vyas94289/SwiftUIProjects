//
//  ValidationView.swift
//  SwiftUIDemo
//
//  Created by Gaurang on 20/12/21.
//

import SwiftUI

struct ValidationView: View {
    @ObservedObject var viewModel = ValidationViewModel()
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 10) {
                    TextFieldWithError(validationPublisher: viewModel.emailValidation, type: .email, text: $viewModel.email)
                    TextFieldWithError(validationPublisher: viewModel.userNameValidation, type: .username, text: $viewModel.userName)
                    SecureTextFieldWithError(validationPublisher: viewModel.passwordValidation, type: .password, text: $viewModel.password)
                }.frame(maxWidth: .infinity)
            }
            .padding(.vertical)
            .background(Color(Colors.darkColor).ignoresSafeArea())
            .navigationBarTitle("Validation", displayMode: .inline)
        }
    }
}

struct ValidationView_Previews: PreviewProvider {
    static var previews: some View {
        ValidationView()
    }
}


