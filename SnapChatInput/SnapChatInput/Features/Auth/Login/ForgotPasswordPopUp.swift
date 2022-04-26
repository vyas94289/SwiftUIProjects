//
//  ForgotPasswordPopUp.swift
//  SnapChatInput
//
//  Created by Gaurang on 20/04/22.
//

import SwiftUI

struct ForgotPasswordPopUp: View {
    @Environment(\.presentationMode) var presentationMode
    @State var backgroundColor: Color = .clear
    var body: some View {
        ZStack {
            VStack(spacing: 14) {
                Text("Please choose how you want to reset your password")
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                Group() {
                    Button("via Phone") {
                        
                    }
                    Button("via Email") {
                        
                    }
                }.buttonStyle(WhiteButtonStyle())
                    .padding(.horizontal, 50)
            
                Button("Cancel".uppercased()) {
                    self.backgroundColor = .clear
                    self.presentationMode.wrappedValue.dismiss()
                }.foregroundColor(.white).font(.caption)
            }
            .padding(12)
            .background(Color.black)
            .cornerRadius(10)
            .padding(40)
            .transition(.asymmetric(insertion: .scale, removal: .opacity))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(backgroundColor)
        
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.animateBackground(true)
            }
        }
    }
    
    func animateBackground(_ presenting: Bool) {
        withAnimation(.easeInOut(duration: 0.3)) {
            self.backgroundColor = presenting ? Color.black.opacity(0.3) : .clear
        }
    }
}

struct BackgroundCleanerView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}


