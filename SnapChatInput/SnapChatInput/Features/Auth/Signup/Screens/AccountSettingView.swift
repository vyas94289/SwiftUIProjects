//
//  AccountSettingView.swift
//  SnapChatInput
//
//  Created by Gaurang on 10/05/22.
//

import SwiftUI

struct AccountSettingView: View {
    @EnvironmentObject var viewModel: SignupViewInfoModel
    var body: some View {
        List {
            NavigationLink(destination: {
                Color.red
            }, label: {
                MenuItemView(title: "Username", value: viewModel.username)
            })
            NavigationLink(destination: {
                Color.blue
            }, label: {
                MenuItemView(title: "Name", value: viewModel.fullName)
            })
            NavigationLink(destination: {
                Color.brown
            }, label: {
                MenuItemView(title: "Birthdate", value: viewModel.birthDateString)
            })
            NavigationLink(destination: {
                Color.yellow
            }, label: {
                Text("Password")
            })
            NavigationLink(destination: {
                Color.themeBlue
            }, label: {
                MenuItemView(title: "Phone", value: viewModel.mobileWithCountryCode)
            })
           
        }.navigationTitle("Account Settings")
    }
}

struct MenuItemView: View {
    let title, value: String
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(value).foregroundColor(.gray)
        }
    }
}

struct AccountSettingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AccountSettingView()
        }
        
    }
}
