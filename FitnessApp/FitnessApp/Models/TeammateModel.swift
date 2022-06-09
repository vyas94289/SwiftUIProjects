//
//  TeammateModel.swift
//  FitnessApp
//
//  Created by Gaurang on 13/05/22.
//

import Foundation
struct TeammateModel: Codable, Identifiable {
    let id: Int
    let name, occupation, about: String
}

