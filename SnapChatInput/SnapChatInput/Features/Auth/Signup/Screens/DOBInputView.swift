//
//  DOBInputView.swift
//  SnapChatInput
//
//  Created by Gaurang on 21/04/22.
//

import Foundation
import SwiftUI

struct DOBInputView: View {
    @EnvironmentObject var viewModel: SignupViewInfoModel
    @State private var pushToUsername: Bool = false
    
    var body: some View {
        AuthContentView(title: "When's your birthday?") {
            
            NavigationLink(destination: UsernameInputView(), isActive: $pushToUsername) {
                EmptyView()
                }.hidden()
            
            ThemeTextField(title: "Birthday", value: $viewModel.birthDateString, errorMessage: .constant(nil))
                .padding(.top, 20)
                .disabled(true)
            
            Spacer()
            
            PrimaryButton(title: "Continue",
                          isProcessing: .constant(false),
                          action: submit)
                .padding(.vertical, 12)
                .padding(.horizontal, 40)
                .disabled(viewModel.birthDateString.isEmpty)
            
            DatePicker("", selection: $viewModel.birthDate, in: ...Date.now, displayedComponents: .date).datePickerStyle(.wheel)
        }.padding(.top, 100)
    }
    private func submit() {
        self.pushToUsername = true
    }
}
