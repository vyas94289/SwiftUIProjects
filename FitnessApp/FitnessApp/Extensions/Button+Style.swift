//
//  Button+Style.swift
//  SnapChatInput
//
//  Created by Gaurang on 19/04/22.
//

import SwiftUI

struct FlatButtonStyle: ButtonStyle {
    let color: Color
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(color.opacity(configuration.isPressed ? 0.7 : 1))
            .font(.title3)
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    @Binding var isLoading: Bool
    @Environment(\.isEnabled) private var isEnabled
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(8)
            .foregroundColor(.white)
            .frame(maxWidth: isLoading ? nil : .infinity)
            .background(isEnabled ? Color(theme: .primary).opacity(configuration.isPressed ? 0.7 : 1) : Color.gray)
            .clipShape(Capsule())
            .animation(.spring(response: 0.55, dampingFraction: 0.55, blendDuration: 0), value: isLoading)
    }
}

struct PrimaryButton: View {
    let title: String
    @Binding var isProcessing: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            ZStack {
                if isProcessing {
                    ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .white))
                } else {
                    Text(title)
                }
            }
            
        })
        .buttonStyle(PrimaryButtonStyle(isLoading: $isProcessing))
    }
}

struct WhiteButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(6)
            .foregroundColor(.black)
            .frame(maxWidth: .infinity)
            .background( Color.white.opacity(configuration.isPressed ? 0.7 : 1))
            .clipShape(Capsule())
            .font(Font.subheadline)
    }
}

