//
//  PostsViewModel.swift
//  ApiDemo
//
//  Created by Gaurang on 07/06/22.
//

import Foundation
import Combine

class PostViewModel: ObservableObject {
    
    @Published var postList: [Post] = []
    private var bag = Set<AnyCancellable>()
    
    func fetchPost() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts?_page=1&_limit=10") else {
            return
        }
        URLSession.shared.dataTaskPublisher(for: url)
            .map({$0.data})
            .decode(type: [Post].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .assign(to: \.postList, on: self)
            .store(in: &bag)
        
    }
}
