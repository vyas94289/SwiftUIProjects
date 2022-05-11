//
//  TextFields.swift
//  SnapChatInput
//
//  Created by Gaurang on 19/04/22.
//

import SwiftUI

/*struct ThemeTextField: View {
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
    @State private var showPassword = true
    @Binding var errorMessage: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            Text(title.capitalized)
                .foregroundColor(.themeGray)
                .font(.caption)
            
            HStack {
                if showPassword {
                    TextField("", text: $value)
                        .font(.callout)
                } else {
                    SecureField("", text: $value)
                        .font(.callout)
                }
                Button(action: {
                    self.showPassword.toggle()
                }, label: {
                    Text(showPassword ? "Hide" : "Show")
                        .font(.caption)
                }).foregroundColor(.themeGray)
            }.frame(height: 36)
            
            Color.themeGray.frame(height: 1)
            
            if errorMessage != nil {
                Text(errorMessage ?? "")
                    .errorStyle()
                    .padding(.top, 2)
            }
        }
    }
}


struct ThemeUnderlineTextField: View {
    let title: String
    @Binding var value: String
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            TextField(title, text: $value)
                .frame(height: 25)
                .font(.callout)
            Color.themeGray.frame(height: 1)
        }
    }
}

struct ThemeUnderlineLabel: View {
    let title: String
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text(title)
                .frame(height: 25)
                .font(.callout)
            Color.themeGray.frame(height: 1)
        }
    }
}
*/
