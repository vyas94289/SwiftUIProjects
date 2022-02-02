//
//  ViewModel.swift
//  OperationAndGCD
//
//  Created by Gaurang Vyas on 01/02/22.
//

import Combine
import UIKit


class ViewModel: ObservableObject {
    @Published var downloadTaskList: [DownloadTask] = []
    let operationQueue = OperationQueue()
    
    func addTask(urlStr: String) {
        if let url = URL(string: urlStr) {
            downloadTaskList.append(.init(url: url, queue: operationQueue))
        }
        let queue = DispatchQueue(
          label: "com.kentakodashima.app.sampleBarrier",
          attributes: .concurrent
        )
    }
    
        // https://pwdown.com/113587/variation/190K/Tera%20Hua%20-%20Arijit%20Singh.mp3
}
