//
//  Post.swift
//  ApiDemo
//
//  Created by Gaurang on 07/06/22.
//

import Foundation

struct Post: Codable, Identifiable {
    let id, userId: Int
    let title, body: String
}
