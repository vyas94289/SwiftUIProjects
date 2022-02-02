//
//  DataPublisher.swift
//  Movies
//
//  Created by Gaurang on 18/01/22.
//

import Combine
import Foundation

class ApiPublisher<T: Codable>: Publisher {

    typealias Output = Result<T, ApiError>
    typealias Failure = Never

    private var urlRequest: URLRequest?
    private var apiError: ApiError?

    init(urlRequest: URLRequest) {
        self.urlRequest = urlRequest
    }

    init(error: ApiError) {
        self.apiError = error
    }

    func receive<S>(subscriber: S) where S : Subscriber, S.Failure == Failure, S.Input == Output {
        guard Reachability.isConnectedToNetwork() else {
            _ = subscriber.receive(.failure(.internetUnavailable))
            return
        }
        if let request = urlRequest {
            let subscription = Publishers.DataSubscription(request: request, subscriber: subscriber)
            subscriber.receive(subscription: subscription)
        } else {
            _ = subscriber.receive(.failure(apiError ?? ApiError.requestModelError("Something went wrong")))
        }

    }
}


// MARK: - Data Subscription

extension Publishers {

    class DataSubscription<S: Subscriber, T: Codable>: Subscription where S.Input == Result<T, ApiError>, S.Failure == Never {
        private let session = URLSession.shared
        private let request: URLRequest
        private var subscriber: S?

        init(request: URLRequest, subscriber: S) {
            self.request = request
            self.subscriber = subscriber
            sendRequest()
        }

        func request(_ demand: Subscribers.Demand) {
            //TODO: - Optionaly Adjust The Demand
        }

        func cancel() {
            subscriber = nil
        }

        private func sendRequest() {
            guard let subscriber = subscriber else { return }
            session.dataTask(with: request) { (data, _, error) in
                if let data = data {
                    do {
                        let model = try JSONDecoder().decode(T.self, from: data)
                        _ = subscriber.receive(.success(model))
                    } catch {
                        _ = subscriber.receive(.failure(ApiError.decodingError(error.localizedDescription)))
                    }
                } else if let error = error {
                    _ = subscriber.receive(.failure(ApiError.decodingError(error.localizedDescription)))
                }
            }.resume()
        }
    }
}
