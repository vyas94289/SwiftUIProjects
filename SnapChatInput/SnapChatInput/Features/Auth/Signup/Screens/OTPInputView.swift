//
//  OTPInputView.swift
//  SnapChatInput
//
//  Created by Gaurang on 02/05/22.
//

import Foundation
import SwiftUI
import Combine

struct OTPInputView: View {
    @EnvironmentObject var viewModel: SignupViewInfoModel
    @State private var pushToAccountSettings: Bool = false
    
    var body: some View {
        AuthContentView(title: "Enter Confirmation Code", subheadLine: "Enter the code we sent to \(viewModel.mobileNumber)") {
            
            NavigationLink(destination: AccountSettingView(), isActive: $pushToAccountSettings) {
                EmptyView()
            }.hidden()
            
            VStack(alignment: .leading) {
                Text("CODE").foregroundColor(.blue)
                OTPField(numberOfFields: 6,
                         otpString: $viewModel.optString,
                         isValidInput: $viewModel.isValidOTPInputs)
            }
            
            Spacer()
            
            PrimaryButton(title: "Continue",
                          isProcessing: .constant(false),
                          action: submit)
                .padding(.vertical, 12)
                .padding(.horizontal, 40)
                .disabled(viewModel.isValidOTPInputs == false)
            
            
        }
        .padding(.top, 100)
    }
    private func submit() {
        self.pushToAccountSettings = true
    }
}
