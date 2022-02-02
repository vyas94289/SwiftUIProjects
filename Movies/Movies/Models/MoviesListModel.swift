//
//  MoviesListModel.swift
//  Movies
//
//  Created by Gaurang on 18/01/22.
//

import Foundation

import Foundation

// MARK: - MoviesList
struct MoviesListModel: Codable {
    let dates: Dates
    let page: Int
    let results: [MovieInfoModel]?
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Dates
struct Dates: Codable {
    let maximum, minimum: String?
}

