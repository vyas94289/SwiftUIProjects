//
//  SignupViewInfoModel.swift
//  SnapChatInput
//
//  Created by Gaurang on 21/04/22.
//

import Combine
import Foundation
import SwiftUI

class SignupViewInfoModel: ObservableObject {
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    var fullName: String {
        [firstName, lastName].filter({$0.isEmpty == false}).joined(separator: " ")
    }
    
    @Published var birthDateString: String = ""
    @Published var birthDate: Date = .now
    @Published var username: String = ""
    @Published var usernameStatus: UsernameValidation = .empty
    @Published var passwordModel = PasswordValidaton()
    @Published var passwordErrorMessage: String?
    @Published var isValidName: Bool = false
 
    @Published var countryInfo: CountryInfo
    @Published var mobileNumber: String = ""
    @Published var isMobileValid: Bool = false
    var mobileWithCountryCode: String {
        "\(countryInfo.dialCode)\(mobileNumber)"
    }
    
    @Published var optString: String = ""
    @Published var isValidOTPInputs: Bool = false
    
    let privacyPolicy = "By tapping Sign Up & Accept, you acknowledge that you have read the [Privacy Policy](https://example.com) and agree to the [Terms of Service](www.google.com)."
    private var disposeBag = Set<AnyCancellable>()
    
    init() {
        let list = CountryInfo.getCountriesFromBundle()
        let locale = Locale.current
        countryInfo = list.first(where: {$0.code == locale.regionCode}) ?? list[0]
        observeFullNameInputs()
        observeDOB()
        observeUsername()
        observeMobileNumber()
    }
    
    private func observeFullNameInputs() {
        Publishers.CombineLatest($firstName, $lastName).sink(receiveValue: { (firstName, lastName) in
            let isValid = !firstName.isEmpty || !lastName.isEmpty
            if isValid != self.isValidName {
                self.isValidName = isValid
            }
        }).store(in: &disposeBag)
    }
    
    private func observeDOB() {
        $birthDate
            .dropFirst()
            .map({DateFormatHelper.fullDate.getDateString(from: $0)})
            .assign(to: &$birthDateString)
    }
    
    private func observeUsername() {
        $username
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .subscribe(on: RunLoop.main)
            .sink { value in
                if value.isEmpty {
                    self.usernameStatus = .empty
                } else if value.first!.isLetter == false {
                    self.usernameStatus = .error(message: "Username must start with a letter 🔠")
                } else if value.count < 3 {
                    self.usernameStatus = .error(message: "Username must be at least 3 characters 📝")
                } else {
                    self.checkUsernameAvailability(value)
                }
            }.store(in: &disposeBag)
    }
    
    private func checkUsernameAvailability(_ value: String) {
        self.usernameStatus = .checking
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [value] in
            guard value == self.username else {
                print("cancelled:", value)
                return
            }
            let availableName = ["vyas", "grng", "tej", "patel"]
            if availableName.contains(value) {
                self.usernameStatus = .error(message: "\(value) is already taken!")
            } else {
                self.usernameStatus = .available
            }
        }
    }
    
    private func observeMobileNumber() {
        $mobileNumber.map({$0.count > 5}).assign(to: &$isMobileValid)
    }
}

extension SignupViewInfoModel {
    enum UsernameValidation {
        case empty
        case error(message: String)
        case available
        case checking
        
        var textColor: Color {
            if case .error = self {
                return .themeRed
            } else {
                return .themeGray
            }
        }
        
        var message: String? {
            switch self {
            case .empty:
                return nil
            case .error(let message):
                return message
            case .available:
                return "Username available"
            case .checking:
                return "Checking..."
            }
        }
        
        var isLoading: Bool {
            if case .checking = self {
                return true
            } else {
                return false
            }
        }
        
        var isValid: Bool {
            if case .available = self {
                return true
            } else {
                return false
            }
        }
    }

}

