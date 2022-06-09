//
//  SessionManager.swift
//  FitnessApp
//
//  Created by Gaurang on 17/05/22.
//

import SwiftUI
import Combine

private struct IsLoggedKey: EnvironmentKey {
  static let defaultValue = false
}

extension EnvironmentValues {
  var isLoggedIn: Bool {
    get { self[IsLoggedKey.self] }
    set { self[IsLoggedKey.self] = newValue }
  }
}

class UserSettings: ObservableObject {
    @Published var isLoggedIn: Bool {
        didSet {
            UserDefaults.standard.set(isLoggedIn, forKey: "isLoggedIn")
        }
    }
    
    init() {
        isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
    }
}

