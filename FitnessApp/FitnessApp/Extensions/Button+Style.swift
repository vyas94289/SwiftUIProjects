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
    let hasFixedWidth: Bool = false
    @Binding var isLoading: Bool
    @Environment(\.isEnabled) private var isEnabled
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(10)
            .foregroundColor(.white)
            .frame(maxWidth: hasFixedWidth ? nil : (isLoading ? nil : .infinity))
            .background(isEnabled ? Color(theme: .primaryLight).opacity(configuration.isPressed ? 0.7 : 1) : Color(theme: .lightGray))
            .cornerRadius(10)
            .animation(.spring(response: 0.55, dampingFraction: 0.55, blendDuration: 0), value: isLoading)
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
    }
}

struct BorderButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(10)
            .foregroundColor(Color(theme: .primaryLight))
            .frame(maxWidth: .infinity)
            .opacity(configuration.isPressed ? 0.7 : 1)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(theme: .primaryLight), lineWidth: 1)
            )
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

struct NextPrevButtonStyle: ButtonStyle {
    let lightStyle: Bool
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 40, height: 40)
            .foregroundColor(lightStyle ? Color(theme: .primaryDark) : Color.white)
            .background(lightStyle ? Color(theme: .primaryLight).opacity(0.4) : Color(theme: .primaryDark))
            .cornerRadius(8)
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            
    }
}

extension View {
    
    func addMenuButton(showSideMenu: Binding<Bool>) -> some View {
        navigationBarItems(leading: Button(action: {
            withAnimation {
                showSideMenu.wrappedValue.toggle()
            }
        }, label: {
            Image(app: .menu).padding(4)
        }))
    }
}
