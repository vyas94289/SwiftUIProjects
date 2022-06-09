//
//  ActivitiesModel.swift
//  FitnessApp
//
//  Created by Gaurang on 13/05/22.
//

import Foundation
import Combine

struct ActivityModel: Codable, Identifiable {
    let id: Int
    let title, by, comment: String
}
