//
//  Convertable.swift
//  Populaw
//
//  Created by Gaurang on 22/10/21.
//

import Foundation

protocol Convertible: Encodable {

}

extension Convertible {

    // implement convert Struct or Class to Dictionary
    func convertToDict() throws -> [String: String] {
        let encoder = JSONEncoder()
        let data = try encoder.encode(self)
        let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
        if let dict = result as? [String: String] {
            return dict
        } else {
            throw ApiError.requestModelError("Failed to convert json object into [String: String]")
        }
    }

    func convertToJsonData() throws -> Data {
        let encoder = JSONEncoder()
        return try encoder.encode(self)
    }
}
