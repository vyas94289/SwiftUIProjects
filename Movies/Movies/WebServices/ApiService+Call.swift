//
//  ApiService + Call.swift
//  Movies
//
//  Created by Gaurang on 18/01/22.
//

import Combine

extension ApiService {

    static func fetchUpcomingMovies(page: Int) -> ApiPublisher<MoviesListModel> {
        let requestModel = RequestModels.Upcoming(page: String(page))
        do {
            let request = try ApiService.generateGetRequest(for: .upcoming, with: requestModel.convertToDict())
            return ApiPublisher(urlRequest: request)
        } catch {
            return ApiPublisher(error: error.eraseToApiError())
        }
    }
}
