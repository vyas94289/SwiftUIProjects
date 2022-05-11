//
//  CountryInfo.swift
//  SnapChatInput
//
//  Created by Gaurang on 02/05/22.
//

import Foundation

struct CountryInfo: Codable {
    let name, flag, code, dialCode: String
    
    enum CodingKeys: String, CodingKey {
        case name, flag, code
        case dialCode = "dial_code"
    }
}

extension CountryInfo {
    
    static func getCountriesFromBundle() -> [CountryInfo] {
        guard let jsonUrl = Bundle.main.url(forResource: "Countries", withExtension: "json") else {
            return []
        }
        do {
            let jsonData = try Data(contentsOf: jsonUrl)
            return try JSONDecoder().decode([CountryInfo].self, from: jsonData)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
