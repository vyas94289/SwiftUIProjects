//
//  ContentView.swift
//  SnapChatInput
//
//  Created by Gaurang on 19/04/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ZStack(alignment: .leading) {
                    Image("snapchat")
                        .offset(x: 0, y: 100)
                }
                .frame( maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .background(Color.themeYellow)
                
                NavigationLink("LOG IN") {
                    LoginView()
                }
                .buttonStyle(FlatButtonStyle(color: .themeRed))
                
                NavigationLink("SIGN UP") {
                    NameInputView()
                }
                .buttonStyle(FlatButtonStyle(color:.themeBlue))
            }
            .foregroundColor(.white)
            .navigationBarHidden(true)
        }.environmentObject(SignupViewInfoModel())
    }
    
    private func loginTapped() {
        
    }
    
    private func signUpTapped() {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
