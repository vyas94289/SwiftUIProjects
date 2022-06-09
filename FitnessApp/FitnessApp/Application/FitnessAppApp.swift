//
//  FitnessAppApp.swift
//  FitnessApp
//
//  Created by Gaurang on 11/05/22.
//

import SwiftUI

@main
struct FitnessAppApp: App {
    
    @ObservedObject var userSettings = UserSettings()
    
    var body: some Scene {
        WindowGroup {
            if userSettings.isLoggedIn {
                AppTabBarView().accentColor(Color(theme: .primary)).environmentObject(userSettings)
            } else {
                OnboardingView().accentColor(Color(theme: .primary)).environmentObject(userSettings)
            }
        }
    }
}
