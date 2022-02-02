//
//  DownloadTask.swift
//  OperationAndGCD
//
//  Created by Gaurang Vyas on 01/02/22.
//

import Foundation
import UIKit

enum DownloadState {
    case paused, running, completed, error
    
    var iconName: String {
        switch self {
        case .paused:
            return "play.circle"
        case .running:
            return "pause.circle"
        case .completed:
            return "checkmark.circle"
        case .error:
            return "arrow.clockwise.circle"
        }
    }
    
    var color: UIColor {
        switch self {
        case .paused:
            return .purple
        case .running:
            return .blue
        case .completed:
            return .green
        case .error:
            return .red
        }
    }
}


class DownloadTask: NSObject, Identifiable, ObservableObject {
    let id = UUID()
    let fileUrl: URL
    @Published var fileName: String = "Unknown"
    @Published var process: Float = 0
    @Published var state: DownloadState = .running
    var buffer = Data()
    var urlSession: URLSession!
    var downloadTask: URLSessionDataTask!
    var expectedContentLength = 0
    
    init(url: URL, queue: OperationQueue) {
        fileUrl = url
        super.init()
        urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: queue)
        downloadTask = urlSession.dataTask(with: url)
        downloadTask.resume()
    }
    
    func pauseDownloading() {
        state = .paused
        downloadTask.progress.pause()
    }
    
    func resumeDownloading() {
        state = .running
        downloadTask.resume()
    }
    
    func canceDownload() {
        downloadTask.cancel()
    }
}

extension DownloadTask: URLSessionDataDelegate {
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse) async -> URLSession.ResponseDisposition {
        expectedContentLength = Int(response.expectedContentLength)
        DispatchQueue.main.async {
            self.fileName = response.suggestedFilename?.removingPercentEncoding ?? "Unknown"
        }
        return .allow
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        buffer.append(data)
        DispatchQueue.main.async {
            self.process = Float(self.buffer.count) / Float(self.expectedContentLength)
        }
        
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        DispatchQueue.main.async {
            if let error = error {
                print(error.localizedDescription)
                self.state = .error
            } else {
                self.state = .completed
            }
        }
       
    }
}
