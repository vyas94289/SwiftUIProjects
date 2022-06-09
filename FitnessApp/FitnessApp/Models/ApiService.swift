//
//  ApiService.swift
//  FitnessApp
//
//  Created by Gaurang on 13/05/22.
//

import Foundation

enum JSonFile: String {
    case activities
    case teammates
    case islands
}

extension JSonFile {
    
    var path: URL? {
        Bundle.main.url(forResource: self.rawValue, withExtension: "json")
    }
    
    func generateDataModel<T: Decodable>() -> T? {
        guard let path = path else {
            print("Couldn't find file path")
            return nil
        }
        do {
            let jsonData = try Data(contentsOf: path)
            return try JSONDecoder().decode(T.self, from: jsonData)
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}

extension Decodable {
    
    static func getModel<T: Decodable>(fromJsonFile jsonFile: JSonFile) -> T? {
        jsonFile.generateDataModel()
    }
    
    static func getArrayModel<T: Decodable>(fromJsonFile jsonFile: JSonFile) -> [T] {
        jsonFile.generateDataModel() ?? []
    }
}
