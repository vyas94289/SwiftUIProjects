//
//  VideoLink.swift
//  InstagramDesgn
//
//  Created by Gaurang Vyas on 13/01/22.
//

import Foundation

struct VideoLink: Identifiable, Codable {
    var id = UUID().uuidString
    let description: String
    let source: String
    let subtitle, thumb, title: String
    
    enum CodingKeys: String, CodingKey {
        case description
        case source, subtitle, thumb, title
    }
}

extension VideoLink {
    static let baseUrl = "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/"
    var thumbUrl: URL {
        return URL(string: VideoLink.baseUrl + thumb)!
    }
    static var fromJsonFile: [VideoLink] {
        guard let url = Bundle.main.url(forResource: "VideosLinks", withExtension: "json") else {
            return []
        }
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([VideoLink].self, from: data)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
