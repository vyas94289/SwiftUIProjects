//
//  RequestModel.swift
//  Movies
//
//  Created by Gaurang on 18/01/22.
//

import Foundation

struct RequestModels {
    struct Upcoming: Convertible {
        let apiKey = WSConstant.apiKey
        let language = WSConstant.language
        let page: String

        enum CodingKeys: String, CodingKey {
            case apiKey = "api_key"
            case language
            case page
        }

    }
}
