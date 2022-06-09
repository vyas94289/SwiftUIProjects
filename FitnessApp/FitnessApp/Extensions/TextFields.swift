//
//  TextFields.swift
//  SnapChatInput
//
//  Created by Gaurang on 19/04/22.
//

import SwiftUI
import Combine

enum InputStatus {
    case idle
    case valid
    case invalid(message: String)
    
    var color: Color {
        switch self {
        case .idle:
            return Color(theme: .lightGray).opacity(0.3)
        case .valid:
            return Color(theme: .primaryLight)
        case .invalid:
            return Color.red
        }
    }
    
    var textColor: Color {
        switch self {
        case .idle:
            return Color(theme: .darkGray)
        case .valid:
            return Color(theme: .primaryLight)
        case .invalid:
            return Color.red
        }
    }
    
    var isValid: Bool {
        if case .valid = self {
            return true
        } else {
            return false
        }
    }
}

class TextFieldObserver: ObservableObject {
    let title: String
    let validator: InputValidation
    @Published var value: String = ""
    @Published var status: InputStatus = .idle
    @Published var error: String?
    private var disposeBag = Set<AnyCancellable>()
    
    init(_ title: String, validator: InputValidation) {
        self.title = title.capitalized
        self.validator = validator
        
        if validator != .optional {
            observeValue()
        }
    }
    
    private func observeValue() {
        $value
            .dropFirst()
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink { value in
                let result = self.validator.isValid(input: value, field: self.title)
                withAnimation(.easeInOut) {
                    if result.isValid {
                        self.status = .valid
                    } else if let error = result.error {
                        self.status = .invalid(message: error)
                    }
                }
            }.store(in: &disposeBag)
    }
}


struct ThemeTextField: View {
    let title: String
    @Binding var value: String
    @Binding var status: InputStatus
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .foregroundColor(Color(theme: .darkGray))
            
            TextField("", text: $value)
                .frame(height: 48)
                .padding(.horizontal)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(theme: .extraLightGray))
                ).overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(status.color, lineWidth: 1)
                )
                .foregroundColor(Color(theme: .darkGray))
            if case .invalid(let error) = status {
                Text(error)
                    .errorStyle()
            }
        }
    }
}

struct ThemeSearchField: View {
    let title: String
    @Binding var value: String
    @Binding var status: InputStatus
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .foregroundColor(Color(theme: .darkGray))
            
            TextField("", text: $value)
                .frame(height: 48)
                .padding(.horizontal)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(theme: .extraLightGray))
                ).overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(status.color, lineWidth: 1)
                )
                .foregroundColor(Color(theme: .darkGray))
            if case .invalid(let error) = status {
                Text(error)
                    .errorStyle()
            }
        }
    }
}


struct ThemePasswordField: View {
    
    let title: String
    @Binding var value: String
    @Binding var status: InputStatus
    @State private var showPassword = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title.capitalized)
                .foregroundColor(Color(theme: .darkGray))
            HStack {
                Group {
                    if showPassword {
                        TextField("", text: $value)
                    } else {
                        SecureField("", text: $value)
                    }
                }
                Button(action: {
                    self.showPassword.toggle()
                }, label: {
                    Text(showPassword ? "Hide" : "Show")
                        .font(.caption)
                }).foregroundColor(Color(theme: .darkGray))
            }
            .frame(height: 48)
            .foregroundColor(Color(theme: .darkGray))
            .padding(.horizontal)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(theme: .extraLightGray))
            ).overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(status.color, lineWidth: 1)
            )
            if case .invalid(let error) = status {
                Text(error)
                    .errorStyle()
            }
        }
    }
}
