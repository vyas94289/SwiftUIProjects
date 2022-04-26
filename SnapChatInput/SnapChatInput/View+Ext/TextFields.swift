//
//  TextFields.swift
//  SnapChatInput
//
//  Created by Gaurang on 19/04/22.
//

import SwiftUI

struct ThemeTextField: View {
    let title: String
    @Binding var value: String
    @Binding var errorMessage: String?
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title.capitalized)
                .foregroundColor(.themeGray)
                .font(.caption)
            TextField("", text: $value)
                .frame(height: 25)
                .font(.callout)
            Color.themeGray.frame(height: 1)
            if errorMessage != nil {
                Text(errorMessage ?? "")
                    .errorStyle()
                    .padding(.top, 2)
            }
        }
    }
}

struct ThemePasswordField: View {
    let title: String
    @Binding var value: String
    @State private var showPassword = false
    @Binding var errorMessage: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            Text(title.capitalized)
                .foregroundColor(.themeGray)
                .font(.caption)
            
            HStack {
                if showPassword {
                    TextField("", text: $value).font(.callout)
                } else {
                    SecureField("", text: $value).font(.callout)
                }
                Button(action: {
                    withAnimation {
                        self.showPassword.toggle()
                    }
                    
                }, label: {
                    Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                }).foregroundColor(.themeGray)
            }.frame(height: 25)
            
            Color.themeGray.frame(height: 1)
            
            if errorMessage != nil {
                Text(errorMessage ?? "")
                    .errorStyle()
                    .padding(.top, 2)
            }
        }
    }
}
