//
//  MobileInputView.swift
//  SnapChatInput
//
//  Created by Gaurang on 02/05/22.
//

import SwiftUI

struct MobileInputView: View {
    @EnvironmentObject var viewModel: SignupViewInfoModel
    @State private var pushToOTP: Bool = false
    @FocusState private var focus: Bool?
    
    var body: some View {
        AuthContentView(title: "What's your\nmobile number?") {
            
            NavigationLink(destination: OTPInputView(), isActive: $pushToOTP) {
                EmptyView()
                }.hidden()
            
            CountryPickerView(country: $viewModel.countryInfo)
            
            HStack {
                ThemeUnderlineLabel(title: viewModel.countryInfo.dialCode).frame(width: 50)
                ThemeUnderlineTextField(title: "phone number", value: $viewModel.mobileNumber)
                    .focused($focus, equals: true)
                    .keyboardType(.decimalPad)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.focus = true
                        }
                    }
            }
            
            Text("We'll send you an SMS verification code.")
                .foregroundColor(.black)
                .font(.caption)
                .multilineTextAlignment(.center)
        
            Spacer()
            
            PrimaryButton(title: "Continue",
                          isProcessing: .constant(false),
                          action: submit)
                .padding(.vertical, 12)
                .padding(.horizontal, 40)
                .disabled(viewModel.isMobileValid == false)
            
        
        }.padding(.top, 100)
    }
    
    private func submit() {
        self.pushToOTP = true
    }
}

