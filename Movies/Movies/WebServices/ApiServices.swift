//
//  ApiServices.swift
//  Movies
//
//  Created by Gaurang on 18/01/22.
//

import Foundation
// https://api.themoviedb.org/3/movie/upcoming?api_key=14bc774791d9d20b3a138bb6e26e2579&language=en-US&page=1
enum WSConstant {
    static let baseUrl = "https://api.themoviedb.org/3/"
    static let apiKey = "14bc774791d9d20b3a138bb6e26e2579"
    static let language = "en"
}

enum WSPaths: String {
    case movie
}

enum WSApi: String {
    case upcoming
}

extension WSApi {
    var path: WSPaths {
        switch self {
        case .upcoming:
            return .movie
        }
    }

    var url: URL {
        return URL(string: "\(WSConstant.baseUrl)\(path.rawValue)/\(rawValue)")!
    }
}

enum HttpMethod: String {
    case get    = "GET"
    case post   = "POST"
}

class ApiService {

    static func addCommonHeaders(to request: inout URLRequest) {
         request.addValue("application/json", forHTTPHeaderField: "Content-Type")
         request.addValue("application/json", forHTTPHeaderField: "Accept")
    }

    static func generateGetRequest(for api: WSApi, with params: [String: String] = [:]) throws -> URLRequest {
        
        let urlStr = api.url.absoluteString
        var urlComponents = URLComponents(string: urlStr)!
        if !params.isEmpty {
            urlComponents.queryItems = params.compactMap({URLQueryItem(name: $0.key, value: String(describing: $0.value))})
        }
        guard let url = urlComponents.url else {
            throw ApiError.urlBuildingError("Error occure during building url components")
        }
        if Helper.isApiLogEnabled {
            print("API path : \(url.absoluteString)")
        }
        var request = URLRequest(url: url)
        ApiService.addCommonHeaders(to: &request)
        request.httpMethod = HttpMethod.get.rawValue
        return request
    }

    static func generatePostRequest(for api: WSApi, with requestModel: Convertible) throws -> URLRequest {
        var request = URLRequest(url: api.url)
        addCommonHeaders(to: &request)
        request.httpMethod = HttpMethod.post.rawValue
        let bodyData = try requestModel.convertToJsonData()
        if Helper.isApiLogEnabled {
            print("API path : \(api.rawValue), Params : \(String(data: bodyData, encoding: .utf8) ?? "")")
        }
        request.httpBody = bodyData
        return request
    }

}


