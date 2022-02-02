//
//  BaseViewModel.swift
//  Movies
//
//  Created by Gaurang on 18/01/22.
//

import Combine

protocol BaseViewModel {
    var event: ViewModelEvent {get}
    func emit(_ event: ViewModelEvent)
    func startSynching()
}

enum ViewModelEvent {
    case loading
    case updateDataModel
    case error(message: String, retryCallback: EmptyClosure?)
}
