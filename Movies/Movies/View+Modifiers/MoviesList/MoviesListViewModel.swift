//
//  MoviesListViewModel.swift
//  Movies
//
//  Created by Gaurang on 18/01/22.
//

import Combine
import SwiftUI

class MoviesListViewModel: ObservableObject, BaseViewModel {
    @Published var movies: [MovieInfoModel] = []
    @Published var page: Int = 1
    var cancellationToken: AnyCancellable?
    @Published var event: ViewModelEvent = .loading

    func emit(_ event: ViewModelEvent) {
        self.event = event
    }

    func startSynching() {
        cancellationToken = ApiService.fetchUpcomingMovies(page: page)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { result in
                switch result {
                case .success(let model):
                    if let list = model.results {
                        self.movies += list
                        self.emit(.updateDataModel)
                    } else {
                        self.emit(.error(message: "No Data Found", retryCallback: nil))
                    }
                case .failure(let error):
                    var retryClosure: EmptyClosure?
                    if error.canRetry {
                        retryClosure = {
                            self.startSynching()
                        }
                    }
                    self.emit(.error(message: error.localizedDescription, retryCallback: retryClosure))
                }
        })
    }



    func fetchMovies() {

    }
    
}
