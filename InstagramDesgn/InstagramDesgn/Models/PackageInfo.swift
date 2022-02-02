//
//  PackageInfo.swift
//  InstagramDesgn
//
//  Created by Gaurang Vyas on 16/01/22.
//

import Foundation

struct PackageInfo: Codable, Identifiable {
    var id = UUID().uuidString
    let name: String
    let classCount: Int
    let price: Double
    enum CodingKeys: String, CodingKey {
        case name, price
        case classCount = "class_count"
    }
}


extension PackageInfo {
    
    var classCountString: String {
        if classCount > 1 {
            return "\(classCount) classes"
        } else {
            return "\(classCount) class"
        }
    }

    static var fromJsonFile: [PackageInfo] {
        guard let url = Bundle.main.url(forResource: "Packages", withExtension: "json") else {
            return []
        }
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([PackageInfo].self, from: data)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
